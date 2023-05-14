class WorksController < ApplicationController

  before_action :set_q, only: [:index,:search]
  def show
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
