module EpisodeRateHelper

  def total_rate (work_rate)
    total = work_rate.impressed + work_rate.comedy + work_rate.love + work_rate.excitement + work_rate.deep 
  end
end
