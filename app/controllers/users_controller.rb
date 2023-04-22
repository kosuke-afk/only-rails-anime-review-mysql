class UsersController < ApplicationController

  
  def edit
  end

  def create
    @user = User.new(params_user)
    if @user.save
      log_in @user
      flash[:success] = "新規作成に成功しました。"
      redirect_to works_index_path
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
