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

  def check_duplication?
    release = Release.where(year: self.year, season: self.season)
    if release.count === 1
      false
    elsif release.count >= 2
      true
    end
  end
end
