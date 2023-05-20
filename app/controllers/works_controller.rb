class WorksController < ApplicationController

  before_action :set_q, only: [:index,:search]
  def show
    @work = Work.find(params[:id])
    @episodes = @work.episodes.order(episode_number: :desc)
    @work_rate = @work.work_rates.find_by(user_id: current_user.id) || @work.work_rates.create(impressed: 0, comedy: 0, love: 0, excitement: 0, deep: 0, user_id: current_user.id)
  end

  def index
    @years = Release.select(:year).distinct
    @seasons = Release.select(:season).distinct
    @works = Work.all.includes(:casts).page(params[:page]);
  end

  def search
    release = @q.result[0]
    @works = release.works.includes(:casts).page(params[:page])
  end

  private

    def set_q
      @q = Release.ransack(params[:q])
    end
end
