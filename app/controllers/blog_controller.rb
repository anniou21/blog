class BlogController < ApplicationController
   # GET /blogs
  def index
    @blogs = Blog.all
  end

  # GET /blogs/:id
  def show
    @blog = Blog.find(params[:id])
    @posts = @blog.posts.order(published_at: :desc)
  end
end
