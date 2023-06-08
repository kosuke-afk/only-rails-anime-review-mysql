class EpisodeRatesController < ApplicationController
  include EpisodeRateHelper

  def edit_open
    user_id = params["id"]
    episode_id = params["episode_id"]
    work_id = params["work_id"]
    @work = Work.find(work_id)
    @episode = Episode.find(episode_id)
    @episode_rate = EpisodeRate.find_by(user_id: user_id, episode_id: episode_id, work_id: work_id)
  end

  def edit_close
    episode_id = params["episode_id"]
    @work = Work.find(params["work_id"])
    @episode = Episode.find(episode_id)
  end
  
  def update
    epParams = params_episode_rate
    work_id = params[:work_id]
    episode_id = params[:episode_id]
    user_id = params[:id]
    @work = Work.find(params[:work_id])
    @episode = Episode.find(params[:episode_id])
    @episode_rate = EpisodeRate.find_by(episode_id: episode_id,user_id: user_id,work_id: work_id)
    @episode_rate.update(
      impressed: epParams[:impressed], 
      comedy: epParams[:comedy], 
      love: epParams[:love], 
      excitement: epParams[:excitement], 
      deep: epParams[:deep]
    )
    episode_rates = EpisodeRate.where(user_id: user_id,work_id: work_id).where.not(impressed: 0,comedy: 0, love: 0, excitement: 0, deep: 0)
    @work_rate = WorkRate.find_by(user_id: user_id, work_id: work_id)
    total_rate = total_rate(@work_rate)
    if episode_rates.count <= 1
      @work_rate.update(
        impressed: epParams[:impressed],
        comedy: epParams[:comedy],
        love: epParams[:love],
        excitement: epParams[:excitement],
        deep: epParams[:deep],
        total: total_rate
      )
    else
      average = WorkRate.rate_averages(episode_rates)
      @work_rate.update(
        impressed: average[:impressed],
        comedy: average[:comedy],
        love: average[:love],
        excitement: average[:excitement],
        deep: average[:deep],
        total: total_rate
      )
    end
    render turbo_stream: [
      turbo_stream.replace("episode-rate-form",partial: "shared/episode_rate_form",locals: {work: @work, episode: @episode, episode_rate: @episode_rate}),
      turbo_stream.replace("work-rate-form", partial: "works/shared/work_rates", locals: {work_rate: @work_rate})
    ], status: :unprocessable_entity
  end

  private

    def params_episode_rate
      params.require(:episode_rate).permit(:impressed,:comedy,:love,:excitement,:deep)
    end
end
