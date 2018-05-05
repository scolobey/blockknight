class BlogPostsController < ApplicationController
  before_action :admin_authorize
  before_action :get_blog_posts, :except => [:create, :show, :update, :destroy]
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy]

  def index

  end

  def show

  end

  def new
    @blog_post = BlogPost.new
  end

  def edit
    admin_authorize
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)

    respond_to do |format|
      if @blog_post.save
        format.html { redirect_to @blog_post, notice: 'Blog Post Created.' }
        format.json { render :show, status: :created, location: @blog_post }
      else
        format.html { render :new }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @blog_post.update(blog_post_params)
        format.html { redirect_to @blog_post, notice: 'Blog Post Created.' }
        format.json { render :show, status: :ok, location: @blog_post }
      else
        format.html { render :edit }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def get_blog_posts
      @blog_posts = BlogPost.all
    end

    def set_blog_post
      @blog_post = BlogPost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_post_params
      params.require(:blog_post).permit(:title, :description, :img, :content)
    end
end
