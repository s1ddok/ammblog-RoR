class PostsController < BaseController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :check_ownership, only: [:destroy]

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to root_path, notice: t(:post_success)
    else
      redirect_to root_path, notice: "#{t(:post_text)} #{@post.errors[:text].first}"
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, notice: t(:post_success_delete)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:user_id, :text)
  end

  def check_ownership
    render status: 401 if @post.user != current_user
  end

end
