class HomeController < ApplicationController
  def top
    session[:modal_close] ||= true
  end

  def create_user_modal
    if session[:modal_close]
      session[:modal_close] = false
      @user = User.new
      render turbo_stream: [
        turbo_stream.replace("modal-form",partial: "home/partial/create_user_modal",locals: {user: @user})
      ]
    else
      session[:modal_close] = true
      render turbo_stream: [
        turbo_stream.remove("form")
      ]
    end
  end

  def login_modal
    if session[:modal_close]
      session[:modal_close] = false
      render turbo_stream: [
        turbo_stream.replace("modal-form",partial: "home/partial/login_modal")
      ]
    else
      session[:modal_close] = true
      render turbo_stream: [
        turbo_stream.remove("form")
      ]
    end
  end
end
