class HomeController < ApplicationController
  def index
    if not current_user
      redirect_to login_path
    end
  end
end
