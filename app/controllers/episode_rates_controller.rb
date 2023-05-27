class EpisodeRatesController < ApplicationController
  include EpisodeRateHelper

  def edit_open
    user_id = params["id"]
    episode_id = params["episode_id"]
    work_id = params["work_id"]
    @work = Work.find(work_id)
    @episode = Episode.find(episode_id)
    @episode_rate = EpisodeRate.find_by(user_id: user_id, episode_id: episode_id, work_id: work_id) || EpisodeRate.create(impressed: 0, comedy: 0, love: 0, excitement: 0, deep: 0, user_id: user_id, episode_id: episode_id,work_id: work_id)
  end

  def edit_close
    episode_id = params["episode_id"]
    @work = Work.find(params["work_id"])
    @episode = Episode.find(episode_id)
  end
  
  def update
    epParams = params_episode_rate
    @work = Work.find(params[:work_id])
    @episode = Episode.find(params[:episode_id])
    @episode_rate = EpisodeRate.find_by(episode_id: params[:episode_id],user_id: params[:id],work_id: params[:work_id])
    @episode_rate.update(
      impressed: epParams[:impressed], 
      comedy: epParams[:comedy], 
      love: epParams[:love], 
      excitement: epParams[:excitement], 
      deep: epParams[:deep]
    )
    render turbo_stream: [
      turbo_stream.replace("episode-rate-form",partial: "shared/episode_rate_form",locals: {work: @work, episode: @episode, episode_rate: @episode_rate})
    ]
  end

  private

    def params_episode_rate
      params.require(:episode_rate).permit(:impressed,:comedy,:love,:excitement,:deep)
    end
end
