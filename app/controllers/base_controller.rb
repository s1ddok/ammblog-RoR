class BaseController < ApplicationController

  before_filter :get_unread_notifications

  def get_unread_notifications

    # get the navbar notification count in all cases
    @new_followers = user_signed_in? ? current_user.not_seen_new_followers : Array.new

  end

end