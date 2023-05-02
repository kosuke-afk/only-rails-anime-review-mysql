class WorksController < ApplicationController
  def show
  end

  def index
    @works = Work.limit(10);
  end
end
