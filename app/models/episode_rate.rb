class EpisodeRate < ApplicationRecord
  belongs_to :episode
  belongs_to :user
  belongs_to :work, primary_key: :annict_id

  def self.create_sample_rates(title_counts:)
      user = User.all
      user.each do |user|
        works = Work.where('episode_count >= 2 AND media != "映画"').sample(title_counts)
        works.each do |work|
          episodes = work.episodes
          if episodes.count != 0
            episodes.each do |episode|
              EpisodeRate.find_or_initialize_by(user_id: user.id, episode_id: episode.id, work_id: work.annict_id).update(impressed: rand(1..100),comedy: rand(1..100), love: rand(1..100), excitement: rand(1..100), deep: rand(1..100))
            end
          end
        end
        registered_work_count_with_ep_rate = EpisodeRate.where(user_id: user.id).group_by { |rate| rate[:work_id]}.length
        while (registered_work_count_with_ep_rate < title_counts) do
          work = Work.where('episode_count >= 2 AND media != "映画"').sample
          episodes = work.episodes
          if episodes.count != 0
            privious_rate_count = EpisodeRate.count
            episodes.each do |episode|
              rate = EpisodeRate.find_or_initialize_by(user_id: user.id, episode_id: episode.id, work_id: work.annict_id)
              if rate.new_record?
                rate.update(impressed: rand(1..100),comedy: rand(1..100), love: rand(1..100), excitement: rand(1..100), deep: rand(1..100))
              end
            end
            after_rate_count = EpisodeRate.count
            if privious_rate_count < after_rate_count
              registered_work_count_with_ep_rate += 1
            end
          end
        end
      end
  end
  
end
