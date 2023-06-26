class WorksController < ApplicationController

  before_action :set_release_q, only: [:index,:search_release]
  before_action :set_work_q, only: [:search_title]
  before_action :set_q, only: [:change_search]
  before_action :reset_session_ranking, only: [:index,:show]
  before_action :reset_work_count, only: [:index, :show]
  def show
    @work = Work.find(params[:id])
    @episodes = @work.episodes.order(sort_number: :asc)
    @work_rate = @work.work_rates.find_by(user_id: current_user.id) || @work.work_rates.create(impressed: 0, comedy: 0, love: 0, excitement: 0, deep: 0, user_id: current_user.id)
    if @episodes.count != 0
      @episodes.each do |episode|
        episode_rate = EpisodeRate.find_or_initialize_by(episode_id: episode.id,user_id: current_user.id,work_id: params[:id])
        if episode_rate.new_record?
          episode_rate.update(impressed: 0,comedy: 0,love: 0,excitement: 0,deep: 0)
        end
      end
    end
  end

  def index
    @years = Release.select(:year).distinct
    @seasons = Release.select(:season).distinct
    @works = Work.all.page(params[:page])
  end


  def search_title
    @works = @q.result
  end

  def search_release
    release = @q.result[0]
    @works = release.works.includes(:casts).page(params[:page])
  end

  def change_search
    if params[:search] === "release"
      @years = Release.select(:year).distinct
      @seasons = Release.select(:season).distinct
    elsif params[:search] === "title"
    end
  end

  private

    def set_release_q
      @q = Release.ransack(params[:q])
    end

    def set_work_q
      @q = Work.ransack(params[:q])
    end

    def set_q
      if params[:search] === "title"
        set_work_q
      elsif params[:search] === "release"
        set_release_q
      end
    end
end
