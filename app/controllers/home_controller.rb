class HomeController < ApplicationController

  before_action :reset_session_ranking, only: [:top]
  before_action :reset_work_count, only: [:top]
  def top
  end

  def create_user_modal
    @user = User.new
  end

  def login_modal
  end
end
