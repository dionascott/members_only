class PostsController < ApplicationController
  before_action :signed_in, only: [:new, :create]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
     if @post.save
       flash[:success] = "Post created!"
       redirect_to posts_path
     else
       render 'new'
     end
  end

  def index
    @posts = Post.order(created_at: :desc)
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
