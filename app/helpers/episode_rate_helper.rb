module EpisodeRateHelper

  def total_rate (rate:,params:)
    if rate === nil
      total = params[:impressed].to_i +  params[:comedy].to_i +  params[:love].to_i +  params[:excitement].to_i +  params[:deep].to_i
    else
      total = rate.impressed + rate.comedy + rate.love + rate.excitement + rate.deep 
    end
  end

end
