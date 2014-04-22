class ApplicationController < ActionController::Base
  force_ssl unless Rails.env.development?
  protect_from_forgery with: :exception

  rescue_from UserNotAuthorized, with: :user_not_authorized

  def user_not_authorized
    render :json => {:error => "error user_not_authorized"}, :status => 401
  end

end
