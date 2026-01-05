class BlogsController < ApplicationController
  before_action :authentificate
  layout 'application2'
  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find(params[:id])
    @posts = @blog.posts.order(created_at: :desc)
  end

  def new
    
  end

  def create
    raise
  end

  def update
    
  end

  def edit
    
  end

  def authentificate
    true
  end
end
