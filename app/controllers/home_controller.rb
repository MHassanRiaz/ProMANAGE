# app/controllers/home_controller.rb
class HomeController < ApplicationController
  def index
    if user_signed_in?
      @projects = current_user.admin? ? Project.all : current_user.projects
    end
  end
end
