class HomeController < ApplicationController
  def top
  end

  def create_user_modal
    @user = User.new
  end

  def login_modal
  end
end
