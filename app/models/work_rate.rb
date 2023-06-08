class WorkRate < ApplicationRecord
  belongs_to :work, primary_key: :annict_id
  belongs_to :user

  def self.sample_work_rate
    users = User.all
    users.each do |user|
      all_work_eprates = EpisodeRate.where(user_id: user.id).group_by { |episode_rate| episode_rate[:work_id] }.values
      all_work_eprates.each do |each_rates|
        work_average = WorkRate.rate_averages(each_rates)
        WorkRate.find_or_initialize_by(user_id: user.id, work_id: each_rates[0].work_id).update(impressed: work_average[:impressed], comedy: work_average[:comedy], love: work_average[:love], excitement: work_average[:excitement], deep: work_average[:deep])
      end
    end
  end

  def self.rate_averages (ep_rates)
    impressed = 0
    comedy = 0
    love = 0
    excitement = 0
    deep = 0
    count = ep_rates.count
    ep_rates.each do |rate|
      impressed += rate.impressed
      comedy += rate.comedy
      love += rate.love
      excitement += rate.excitement
      deep += rate.deep
    end
    if ep_rates.count === 1
      return average = {impressed: impressed,comedy: comedy,love: love,excitement: excitement,deep: deep}
    else
      im_average = (impressed.to_f / count)
      co_average = (comedy.to_f / count)
      lo_average = (love.to_f / count)
      ex_average = (excitement.to_f / count)
      de_average = (deep.to_f / count)
      return average = {impressed: im_average, comedy: co_average, love: lo_average, excitement: ex_average, deep: de_average}
    end
  end

end
