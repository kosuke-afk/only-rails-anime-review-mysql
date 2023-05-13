class Episode < ApplicationRecord
  belongs_to :work, primary_key: :annict_id

  def self.all_register
    @works = Work.all
    @works.each do |work|
      episodes = Annict::Episode.fetch_episodes(work)
      episodes.each do |episode|
        Episode.find_or_create_by(title: episode["title"],work_id: episode["work"]["id"],episode_number: episode["number_text"])
      end
    end
  end
  
end
