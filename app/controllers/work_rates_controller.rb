class WorkRatesController < ApplicationController

  
  def index
    @ranking = session[:ranking] || params[:ranking]
    @works = Work.fetch_works_each_params(@ranking,current_user.id).page(params[:page])
    if turbo_frame_request?
      @work_count = session[:work_count]
    else
      @work_count = 0
      reset_work_count
    end
    set_work_count(@work_count + @works.count)
    session[:ranking] = params[:ranking]
  end

end
