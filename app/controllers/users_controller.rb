class UsersController < ApplicationController

  def show
    @total_works = Work.joins(:work_rates).select('works.annict_id, works.title, works.image, work_rates.total AS score').where('work_rates.user_id=? AND work_rates.total Is NOT NULL',current_user.id).order('work_rates.total DESC').limit(10)
    @impressed_works = Work.joins(:work_rates).select('works.annict_id, works.title, works.image, work_rates.impressed AS score').where('work_rates.user_id=?', current_user.id).order('work_rates.impressed DESC').limit(10)
    @love_works = Work.joins(:work_rates).select('works.annict_id, works.title, works.image, work_rates.love AS score').where('work_rates.user_id=?', current_user.id).order('work_rates.love DESC').limit(10)
    @comedy_works = Work.joins(:work_rates).select('works.annict_id, works.title, works.image, work_rates.comedy AS score').where('work_rates.user_id=?', current_user.id).order('work_rates.comedy DESC').limit(10)
    @excitement_works = Work.joins(:work_rates).select('works.annict_id, works.title, works.image, work_rates.excitement AS score').where('work_rates.user_id=?', current_user.id).order('work_rates.excitement DESC').limit(10)
    @deep_works = Work.joins(:work_rates).select('works.annict_id, works.title, works.image, work_rates.deep AS score').where('work_rates.user_id=?', current_user.id).order('work_rates.deep DESC').limit(10)
  end
  
  def edit
  end

  def create
    @user = User.new(params_user)
    if @user.save
      log_in @user
      flash[:success] = "新規作成に成功しました。"
      redirect_to works_path, status: :see_other
    else
      flash.now[:danger] = @user.errors.full_messages
      render turbo_stream: [
        turbo_stream.replace("error-area",partial: "home/partial/error_messages")
      ]
    end
  end


  private

    def params_user
      params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end
  
end
