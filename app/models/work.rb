class Work < ApplicationRecord
  self.primary_key = :annict_id
  has_many :episodes
  has_many :work_rates
  has_many :users, through: :work_rates
  def self.create_or_update(work:,year:,season:)
    Work.find_or_initialize_by(title: work["title"]).update(
      year: year,
      season: season,
      title_kana: work["title_kana"],
      image: work["images"]["recommended_url"] || "",
      episode_count: work["episodes_count"],
      media: work["media_text"]
    )
  end

  def self.register_annict_data start_year=2005, end_year=Date.today.year
    seasons = ["spring","summer","autumn","winter"]
    (start_year..end_year).each do |year|
      seasons.each do |season|
        works = Annict::Work.get_total_works(year: year,season: season)
        total_page = (works["total_count"] / 50.to_f).ceil
        current_page = 1
        while (current_page <= total_page)
          works = Annict::Work.get_registration_data(year: year,season: season,page: current_page)
          works.each do |work|
            self.create_or_update(work: work,year: year, season: season)
          end
          current_page += 1
        end
      end
    end
  end
end
