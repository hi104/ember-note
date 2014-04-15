class HomeController < ApplicationController
  def index
    if not current_user
      redirect_to sign_in_path
    end
  end
end
