class Release < ApplicationRecord
  has_many :works

  def self.register(sYear,eYear)
    (sYear..eYear).each do |year|
      seasons = ["春","夏","秋","冬"]
      seasons.each do |season|
        Release.find_or_create_by(year: year,season: season)
      end
    end
  end

end
