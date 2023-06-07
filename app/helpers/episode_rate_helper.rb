require 'bigdecimal'
module EpisodeRateHelper

  def rate_averages (ep_rates)
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

  def total_rate (work_rate)
    total = work_rate.impressed + work_rate.comedy + work_rate.love + work_rate.excitement + work_rate.deep 
  end
end
