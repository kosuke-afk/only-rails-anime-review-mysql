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

    def self.fetch_work(title)
      base_url = "https://api.annict.com"
      access_token = ENV['ANNICT_ACCESS_TOKEN']
      title = URI.encode_www_form_component(title)
      uri = "#{base_url}/v1/works?fields=title,media_text,images,season_name,episodes_count,id&filter_title=#{title}&access_token=#{access_token}"
      data = JSON.parse(Faraday.get(uri).body)["works"]
    end
    

    def self.fetch_works(quantity: 10, exceptMovie: true)
      base_url = "https://api.annict.com"
      access_token = ENV['ANNICT_ACCESS_TOKEN']
      page = 1
      uri = "#{base_url}/v1/works?fields=title,media_text,images,season_name,episodes_count,id&per_page=#{quantity}&page=#{page}&access_token=#{access_token}"
      all_works = JSON.parse(Faraday.get(uri).body)["works"]
      if exceptMovie
        episode_works = all_works.select { |work| work["episodes_count"] != 0 && work["media_text"] != "映画"}
        shortage_works = quantity - episode_works.count
        if episode_works.count != quantity
          page += 1 
          second_uri = "#{base_url}/v1/works?fields=title,media_text,images,season_name,episodes_count,id&per_page=#{quantity}&page=#{page}&access_token=#{access_token}"
          second_all_works = JSON.parse(Faraday.get(second_uri).body)["works"]
          second_episode_works = second_all_works.select do |work|  
            work["episodes_count"] >= 2 && work["media_text"] != "映画"
          end
          add_episode_works = second_episode_works[0..shortage_works-1]
          episode_works.concat(add_episode_works)
        end
        return episode_works 
      end
      return all_works
    end

  end

  class Episode
    def self.fetch_episodes(work)
      base_url = "https://api.annict.com"
      access_token = ENV['ANNICT_ACCESS_TOKEN']
      JSON.parse(Faraday.get("#{base_url}/v1/episodes?fields=sort_number,title,number_text,work.title,work.id&filter_work_id=#{work.annict_id}&sort_id=asc&access_token=#{access_token}").body)["episodes"]
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