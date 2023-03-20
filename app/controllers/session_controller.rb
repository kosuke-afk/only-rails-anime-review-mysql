class SessionController < ApplicationController
  def login
    @user = User.find_by(email: params_login[:email])
    if @user.present? && @user.authenticate(params_login[:password])
      log_in @user
      session[:modal_close] = false
      flash[:success] = "ログインしました。"
      redirect_to root_path
    else
      flash.now[:danger] = ["メールアドレスまたはパスワードが違います"]
    end
  end

  def logout
    if logged_in?
      log_out
      flash[:success] = "ログアウトしました"
      redirect_to root_path
    end
  end
  
  def example
    redirect_to works_index_path
  end
  private

    def params_login
      params.require(:user).permit(:email,:password)
    end
end
