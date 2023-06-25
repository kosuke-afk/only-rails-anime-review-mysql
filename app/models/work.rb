class Work < ApplicationRecord
  self.primary_key = :annict_id
  belongs_to :release
  has_many :casts
  has_many :episodes
  has_many :work_rates
  has_many :users, through: :work_rates
  has_many :episode_rates

  def self.fetch_works_each_params(ranking,user_id)
    case ranking
    when "total"
      return Work.joins(:work_rates).
          select('works.annict_id, works.title, works.image, work_rates.total, work_rates.impressed, work_rates.love, work_rates.comedy, work_rates.excitement, work_rates.deep').
          where('(work_rates.user_id = ?) AND (work_rates.total != 0 AND work_rates.total IS NOT NULL)', user_id).
          order('work_rates.total DESC')
    when "impressed"
      return Work.joins(:work_rates).
          select('works.annict_id, works.title, works.image, work_rates.total, work_rates.impressed, work_rates.love, work_rates.comedy, work_rates.excitement, work_rates.deep').
          where('(work_rates.user_id = ?) AND (work_rates.impressed != 0 AND work_rates.impressed IS NOT NULL)', user_id).
          order('work_rates.impressed DESC')
    when "love"
      return Work.joins(:work_rates).
          select('works.annict_id, works.title, works.image, work_rates.total, work_rates.impressed, work_rates.love, work_rates.comedy, work_rates.excitement, work_rates.deep').
          where('(work_rates.user_id = ?) AND (work_rates.love != 0 AND work_rates.love IS NOT NULL)', user_id).
          order('work_rates.love DESC')
    when "comedy"
      return Work.joins(:work_rates).
          select('works.annict_id, works.title, works.image, work_rates.total, work_rates.impressed, work_rates.love, work_rates.comedy, work_rates.excitement, work_rates.deep').
          where('(work_rates.user_id = ?) AND (work_rates.comedy != 0 AND work_rates.comedy IS NOT NULL)', user_id).
          order('work_rates.comedy DESC')
    when "excitement"
      return Work.joins(:work_rates).
          select('works.annict_id, works.title, works.image, work_rates.total, work_rates.impressed, work_rates.love, work_rates.comedy, work_rates.excitement, work_rates.deep').
          where('(work_rates.user_id = ?) AND (work_rates.excitement != 0 AND work_rates.excitement IS NOT NULL)', user_id).
          order('work_rates.excitement DESC')
    when "deep"
      return Work.joins(:work_rates).
          select('works.annict_id, works.title, works.image, work_rates.total, work_rates.impressed, work_rates.love, work_rates.comedy, work_rates.excitement, work_rates.deep').
          where('(work_rates.user_id = ?) AND (work_rates.deep != 0 AND work_rates.deep IS NOT NULL)', user_id).
          order('work_rates.deep DESC')
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["title"]
  end

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
