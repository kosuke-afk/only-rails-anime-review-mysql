class Work < ApplicationRecord
  self.primary_key = :annict_id
  belongs_to :release
  has_many :casts
  has_many :episodes
  has_many :work_rates
  has_many :users, through: :work_rates

  

  def self.create_or_update(work:,release_id:)
     Work.find_or_initialize_by(title: work["title"]).update(
        title_kana: work["title_kana"],
        image: work["images"]["recommended_url"] || "",
        episode_count: work["episodes_count"],
        media: work["media_text"],
        release_id: release_id,
        annict_id: work["id"]
      )
     @work = Work.find_by(title: work["title"])
  end

  def self.create_sample_data(quantity: 15)
    works = Annict::Work.fetch_work(quantity: quantity)
    works.each do |work|
      @work = Work.create(title: work["title"],annict_id: work["id"],release_id: Release.first.id)
    end
  end

  def check_duplication?
    @work = Work.where(
      title_kana: self.title_kana)
    if @work.count === 1
      false
    elsif @work.count >= 2
      true
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["annict_id", "created_at", "episode_count", "image", "media", "title", "title_kana", "updated_at"]
  end
  
  def self.register_work(title)
    work = Annict::Work.fetch_work(title)
    
  end
  def self.register_annict_data releases
    releases.each do |release|
      year = release["year"]
      season = release["season"]
      season = case season
                when "春"
                  season = "spring"
                when "夏"
                  season = "summer"
                when "秋"
                  season = "autumn"
                when "冬" 
                  season = "winter"
                end
      works = Annict::Work.fetch_all_works(year: year,season: season)
      total_page = (works["total_count"] / 50.to_f).ceil
      current_page = 1
      while (current_page <= total_page)
        works = Annict::Work.fetch_works_each_page(year: year,season: season,page: current_page)
        works.each do |work|
          self.create_or_update(work: work, release_id: release.id)
        end
        current_page += 1
      end
    end
  end
end
