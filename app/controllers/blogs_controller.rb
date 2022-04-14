class BlogsController < ApplicationController
  before_action :set_blog, only: %i[ show edit update destroy ]

  # get all blogs
  def index
    search_with = { user_id: @current_user.id } if params[:page_selection].present?
    @blogs = Blog.filter_by_name(params[:search]).where(search_with).paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @comments = @blog.comments
  end

  def new
    @blog = Blog.new
  end

  def edit
  end

  def create
    @blog = @current_user.blogs.new(blog_params)
    @blog.image.attach(params[:image]) if params[:image].present?
    respond_to do |format|
      if @blog.save
        format.html { redirect_to blog_path(@blog), notice: "Blog was successfully created." }
      else
        format.html { render blog_path, notice: "Something went worng."}
      end
    end
  end

  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to blog_path(@blog), notice: "Blog was successfully updated." }
      else
        format.html { render blog_path, notice: "Something went worng." }
      end
    end
  end
  
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_path, notice: "Blog was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  private
  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:name, :body, :image)
  end

end
