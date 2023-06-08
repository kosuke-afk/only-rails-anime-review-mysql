class Work < ApplicationRecord
  self.primary_key = :annict_id
  belongs_to :release
  has_many :casts
  has_many :episodes
  has_many :work_rates
  has_many :users, through: :work_rates
  has_many :episode_rates

  

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


  def self.ransackable_attributes(auth_object = nil)
    ["annict_id", "created_at", "episode_count", "image", "media", "title", "title_kana", "updated_at"]
  end

  def self.change_season_for_jp (season)
      case season
      when "spring"
        "春"
      when "summer"
        "夏"
      when "autumn"
        "秋"
      when "winter"
        "冬"
      end
  end
    
  def self.change_season_for_eg (season)
    case season
      when "春"
        "spring"
      when "夏"
        "summer"
      when "秋"
          "autumn"
      when "冬" 
          "winter"
      end
  end
  

  def self.register_annict_data releases
    releases.each do |release|
      year = release["year"]
      season = Work.change_season_for_eg(release["season"])
      all_works = Annict::Work.fetch_all_works(year: year,season: season)
      total_data = all_works["total_count"]
      total_page = (total_data / 50.to_f).ceil
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
