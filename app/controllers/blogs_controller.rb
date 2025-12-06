class BlogsController < ApplicationController

  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find(params[:id])
    @posts = @blog.posts.order(published_at: :desc)
  end

end
