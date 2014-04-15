
class Users::SessionsController < Devise::SessionsController

  layout "login"

  def new
    super

    p resource
  end

  def create
    super
  end

end
