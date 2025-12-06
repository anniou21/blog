class PostsController < ApplicationController
  before_action :set_blog, only: [:index, :new, :create]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /blogs/:blog_id/posts
  def index
    @posts = @blog.posts.order(published_at: :desc)
  end

  # GET /posts/:id
  def show
    @comments = @post.comments.order(created_at: :desc)
    @comment  = Comment.new
  end

  # GET /blogs/:blog_id/posts/new
  def new
    @post = @blog.posts.new
  end

  # POST /blogs/:blog_id/posts
  def create
    @post = @blog.posts.new(post_params)
    if @post.save
      redirect_to [@blog, @post], notice: "Article créé avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /posts/:id/edit
  def edit
  end

  # PATCH/PUT /posts/:id
  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Article mis à jour."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/:id
  def destroy
    blog = @post.blog
    @post.destroy
    redirect_to blog_posts_path(blog), notice: "Article supprimé."
  end

  private

  def set_blog
    @blog = Blog.find(params[:blog_id])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :published_at)
  end
end
