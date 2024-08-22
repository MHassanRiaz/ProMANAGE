class HomeController < ApplicationController
  def index
    if user_signed_in?
      if current_user.admin?
        @projects = Project.active
      else
        @projects = current_user.projects.active
      end
    else
      @projects = Project.active
      flash.now[:info] = "Welcome! Please sign in to access your projects." # Example message for non-signed-in users
    end
  end
end
