module EpisodeRateHelper

  def total_rate (rate)
    total = rate.impressed + rate.comedy + rate.love + rate.excitement + rate.deep 
  end
end
