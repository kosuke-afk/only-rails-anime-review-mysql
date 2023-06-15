class WorkRatesController < ApplicationController

  
  def index
    if turbo_frame_request?
      @work_count = session[:work_count]
      @ranking = session[:ranking]
      @next_page = session[:next_page] + 1
    else
      @work_count = 0
      @ranking = params[:ranking]
      @ranking_title = title_each_params(@ranking)
      @next_page = 2
      reset_work_count
    end
    @works = Work.fetch_works_each_params(@ranking,current_user.id).page(params[:page])
    set_work_count(@work_count + @works.count)
    session[:next_page] = @next_page
    session[:ranking] = @ranking
  end

  def total
    @work_count = 0
    @next_page = 2
    @ranking = params[:ranking]
    @ranking_title = title_each_params(@ranking)
    @works = Work.fetch_works_each_params(@ranking,current_user.id).page(params[:page])
    set_work_count(@works.count)
    session[:ranking] = @ranking
    session[:next_page] = @next_page
  end

  def impressed
    @work_count = 0
    @next_page = 2
    @ranking = params[:ranking]
    @ranking_title = title_each_params(@ranking)
    @works = Work.fetch_works_each_params(@ranking,current_user.id).page(params[:page])
    set_work_count(@works.count)
    session[:ranking] = @ranking
    session[:next_page] = @next_page
  end

  def love
    @work_count = 0
    @next_page = 2
    @ranking = params[:ranking]
    @ranking_title = title_each_params(@ranking)
    @works = Work.fetch_works_each_params(@ranking,current_user.id).page(params[:page])
    set_work_count(@works.count)
    session[:ranking] = @ranking
    session[:next_page] = @next_page
  end

  def comedy
    @work_count = 0
    @next_page = 2
    @ranking = params[:ranking]
    @ranking_title = title_each_params(@ranking)
    @works = Work.fetch_works_each_params(@ranking,current_user.id).page(params[:page])
    set_work_count(@works.count)
    session[:ranking] = @ranking
    session[:next_page] = @next_page
  end

  def excitement
    @work_count = 0
    @next_page = 2
    @ranking = params[:ranking]
    @ranking_title = title_each_params(@ranking)
    @works = Work.fetch_works_each_params(@ranking,current_user.id).page(params[:page])
    set_work_count(@works.count)
    session[:ranking] = @ranking
    session[:next_page] = @next_page
  end

  def deep
    @work_count = 0
    @next_page = 2
    @ranking = params[:ranking]
    @ranking_title = title_each_params(@ranking)
    @works = Work.fetch_works_each_params(@ranking,current_user.id).page(params[:page])
    set_work_count(@works.count)
    session[:ranking] = @ranking
    session[:next_page] = @next_page
  end

end
