class WorkRatesController < ApplicationController

  def update
    parameter = params_work_rates
    @work_rate = WorkRate.find(params["id"])
    @work_rate.update(impressed: parameter["impressed"], comedy: parameter["comedy"], love: parameter["love"], excitement: parameter["excitement"],  deep: parameter["deep"])
    render turbo_stream: [
      turbo_stream.replace("work-rate", partial: "work_rates/shared/work_rates")
    ]
  end

  private

  def params_work_rates
    params.require(:work_rate).permit(:impressed,:comedy,:love,:excitement,:deep,:id)
  end
end
