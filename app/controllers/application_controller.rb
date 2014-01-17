class ApplicationController < ActionController::Base
  force_ssl unless Rails.env.development?
  protect_from_forgery with: :exception
end
