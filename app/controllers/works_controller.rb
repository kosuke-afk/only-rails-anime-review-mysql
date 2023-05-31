class WorksController < ApplicationController

  before_action :set_q, only: [:index,:search]
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
