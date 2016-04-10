class RestrictedAreaController < BaseController
  before_action :authenticate_user!

  def authenticate_user
    user_signed_in?  
  end

end