class UsersController < ApplicationController

  before_action :reset_session_ranking, only: [:show,:edit]
  before_action :reset_work_count, only: [:show,:edit]
  def show
    @total_works = Work.joins(:work_rates).select('works.annict_id, works.title, works.image, work_rates.total AS score').where('work_rates.user_id=? AND work_rates.total Is NOT NULL',current_user.id).order('work_rates.total DESC').limit(10)
    @impressed_works = Work.joins(:work_rates).select('works.annict_id, works.title, works.image, work_rates.impressed AS score').where('work_rates.user_id=?', current_user.id).order('work_rates.impressed DESC').limit(10)
    @love_works = Work.joins(:work_rates).select('works.annict_id, works.title, works.image, work_rates.love AS score').where('work_rates.user_id=?', current_user.id).order('work_rates.love DESC').limit(10)
    @comedy_works = Work.joins(:work_rates).select('works.annict_id, works.title, works.image, work_rates.comedy AS score').where('work_rates.user_id=?', current_user.id).order('work_rates.comedy DESC').limit(10)
    @excitement_works = Work.joins(:work_rates).select('works.annict_id, works.title, works.image, work_rates.excitement AS score').where('work_rates.user_id=?', current_user.id).order('work_rates.excitement DESC').limit(10)
    @deep_works = Work.joins(:work_rates).select('works.annict_id, works.title, works.image, work_rates.deep AS score').where('work_rates.user_id=?', current_user.id).order('work_rates.deep DESC').limit(10)
  end
  
  def edit
    @user = current_user
  end

  def create
    @user = User.new(params_create_user)
    if @user.save
      log_in @user
      flash[:success] = "新規作成に成功しました。"
      redirect_to works_path, status: :see_other
    else
      flash.now[:danger] = @user.errors.full_messages
      render turbo_stream: [
        turbo_stream.replace("error-area",partial: "shared/error_messages")
      ]
    end
  end

  def update
    @params = params_update_user 
    @user = User.find_by(name: @params[:name], email: @params[:email])
    if (@user.present? && @user.authenticate(@params[:current_password])) && (@user.update(password: @params[:new_password],password_confirmation: @params[:new_pass_confirmation]))
      flash[:success] = "パスワードを更新しました"
      redirect_to edit_user_path, status: :see_other
    else
      flash.now[:danger] = ["正しいパスワードを入力してください"]
      render turbo_stream: [
        turbo_stream.replace("error-area", partial: "shared/error_messages")
      ]
    end
  end

  private

    def params_create_user
      params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end

    def params_update_user
      params.require(:user).permit(:name, :email, :current_password, :new_password, :new_pass_confirmation)
    end
  
end
