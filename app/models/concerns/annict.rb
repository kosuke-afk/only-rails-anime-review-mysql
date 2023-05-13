module Annict
  extend ActiveSupport::Concern
  
  class Work
    def self.fetch_all_works(year:,season:)
      base_url = "https://api.annict.com"
      access_token = ENV['ANNICT_ACCESS_TOKEN']
      JSON.parse(Faraday.get("#{base_url}/v1/works?per_page=50&filter_season=#{year}-#{season}&access_token=#{access_token}").body)
    end

    def self.fetch_works_each_page(year:,season:,page:)
      base_url = "https://api.annict.com"
      access_token = ENV['ANNICT_ACCESS_TOKEN']
      JSON.parse(Faraday.get("#{base_url}/v1/works?fields=title,media_text,images,season_name,episodes_count,id&per_page=50&filter_season=#{year}-#{season}&page=#{page}&sort_season=desc&access_token=#{access_token}").body)["works"]
    end

    def self.fetch_work(title: nil,quantity: nil)
      base_url = "https://api.annict.com"
      access_token = ENV['ANNICT_ACCESS_TOKEN']
      if title
        title = URI.encode_www_form_component(title)
        uri = "#{base_url}/v1/works?fields=title,media_text,images,season_name,episodes_count,id&filter_title=#{title}&access_token=#{access_token}"
      elsif quantity
        uri = "#{base_url}/v1/works?fields=title,media_text,images,season_name,episodes_count,id&per_page=#{quantity}&access_token=#{access_token}"
      end
      JSON.parse(Faraday.get(uri).body)["works"]
    end
  end

  class Episode
    def self.fetch_episodes(work)
      base_url = "https://api.annict.com"
      access_token = ENV['ANNICT_ACCESS_TOKEN']
      JSON.parse(Faraday.get("#{base_url}/v1/episodes?fields=title,number_text,work.title,work.id&filter_work_id=#{work.annict_id}&sort_id=asc&access_token=#{access_token}").body)["episodes"]
    end
  end

  class Cast
    def self.fetch_casts(work)
      base_url = "https://api.annict.com"
      access_token = ENV['ANNICT_ACCESS_TOKEN']
      JSON.parse(Faraday.get("#{base_url}/v1/casts?fields=character.name,person.name,work.title,work.id&filter_work_id=#{work.annict_id}&sort_id=asc&access_token=#{access_token}").body)["casts"]
    end
  end
end