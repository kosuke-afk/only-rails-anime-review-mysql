module TestMethod 
  extend ActiveSupport::Concern

  class Work < Work
    def self.create_sample_data(quantity: 15)
      works = Annict::Work.fetch_works(quantity: quantity)
      works.each do |work|
        @work = Work.create(title: work["title"],annict_id: work["id"],release_id: Release.first.id, episode_count: work["episodes_count"],media: work["media_text"])
      end
    end

    

      def self.check_duplication?(title_kana)
        @work = Work.where(
          title_kana: title_kana)
        if @work.count === 1
          false
        elsif @work.count >= 2
          true
        end
      end
  end

  class Episode < Episode
    def self.limit_register(count)
      @works = Work.limit(count)
      @works.each do |work|
        episodes = Annict::Episode.fetch_episodes(work)
        episodes.each do |episode|
          Episode.find_or_create_by(sort_number: episode["sort_number"],title: episode["title"],work_id: episode["work"]["id"],episode_number: episode["number_text"])
        end
      end
    end
  end

  class Release < Release
    def self.check_duplication?(year,season)
      release = Release.where(year: year, season: season)
      if release.count === 1
        false
      elsif release.count >= 2
        true
      end
    end
  end
end