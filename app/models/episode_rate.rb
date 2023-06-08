class EpisodeRate < ApplicationRecord
  belongs_to :episode
  belongs_to :user
  belongs_to :work, primary_key: :annict_id

  def self.create_sample_rates(title_counts:,user:)
      works = Work.where('episode_count >= 2 AND media != "映画"').limit(title_counts)
      works.each do |work|
        episodes = work.episodes
          episodes.each do |episode|
            EpisodeRate.find_or_initialize_by(user_id: user.id, episode_id: episode.id, work_id: work.annict_id).update(impressed: rand(1..100),comedy: rand(1..100), love: rand(1..100), excitement: rand(1..100), deep: rand(1..100))
          end
      end
  end
  
end
