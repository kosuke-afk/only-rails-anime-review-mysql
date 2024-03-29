class Release < ApplicationRecord
  has_many :works

  def self.ransackable_attributes(auth_object = nil)
    ["year","season"]
  end

  def self.register(sYear,eYear)
    releases = []
    (sYear..eYear).each do |year|
      seasons = ["春","夏","秋","冬"]
      seasons.each do |season|
        Release.find_or_create_by(year: year,season: season)
      end
      releases.push(*self.where(year: year))
    end
    return releases
  end

  
end
