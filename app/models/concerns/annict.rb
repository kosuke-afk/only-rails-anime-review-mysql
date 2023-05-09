module Annict
  extend ActiveSupport::Concern
  
  class Work
    def self.fetch_all_works(year:,season:)
      base_url = "https://api.annict.com"
      access_token = ENV['ANNICT_ACCESS_TOKEN']
      JSON.parse(Faraday.get("#{base_url}/v1/works?per_page=50&filter_season=#{year}-#{season}&access_token=#{access_token}").body)
    end

    def self.fetch_works(year:,season:,page:)
      base_url = "https://api.annict.com"
      access_token = ENV['ANNICT_ACCESS_TOKEN']
      JSON.parse(Faraday.get("#{base_url}/v1/works?fields=title,media_text,images,season_name,episodes_count,id&per_page=50&filter_season=#{year}-#{season}&page=#{page}&sort_season=desc&access_token=#{access_token}").body)["works"]
    end

  end
end