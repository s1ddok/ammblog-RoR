class HomeController < BaseController
  before_action :timeline_setup, only: [:index]

  def index

    if params[:username] then

      # show the specified user timeline
      @timeline_user = User.find_by_username(params[:username])

      if @timeline_user then
        # get the specified user timeline
        @latest_posts = Post.all_by_username(params[:username]).page(params[:page])

        # if we are logged in check if the user is following
        @is_following = current_user.is_following(@timeline_user) if user_signed_in?

      else
        flash[:error] = t(:cant_find_user)
      end

    else

      # if not, just show our timeline
      # if the user is not logged in, and no user has been specified just show latest posts
      @latest_posts = (user_signed_in? ? Post.where("user_id IN (?) OR user_id = ?", current_user.following.select(:id), current_user.id) : Post.all).page(params[:page])

    end

  end

  def timeline_setup

    @post = Post.new
    @timeline_user = current_user

    #if params[:username] && @timeline_user then
    #  redirect_to root_path if @timeline_user.username == params[:username]
    #end

   end

end
