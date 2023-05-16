class SessionController < ApplicationController
  def login
    @user = User.find_by(email: params_login[:email])
    if @user.present? && @user.authenticate(params_login[:password])
      log_in @user
      session[:modal_close] = false
      flash.now[:success] = "ログインしました。"
      redirect_to works_path, status: :see_other
    else
      flash.now[:danger] = ["メールアドレスまたはパスワードが違います"]
      render turbo_stream: [
        turbo_stream.replace("error-area", partial: "home/partial/error_messages" )
      ], status: :unprocessable_entity
    end
  end

  def logout
    if logged_in?
      log_out
      flash[:success] = "ログアウトしました"
      redirect_to root_path, status: :see_other
    end
  end
  
  private

    def params_login
      params.require(:user).permit(:email,:password)
    end
end
