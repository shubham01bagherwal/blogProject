class CommentsController < ApplicationController
  before_action :set_blog
  before_action :set_comment, only: %i[ destroy ]

  def create
    @comment = (params[:comment_id].nil? ? @blog.comments.new(comment_params) : get_commentable.comments.new(comment_params))
    @comment.user_id = @current_user.id
    respond_to do |format|
      if @comment.save
        format.turbo_stream
      else
        format.turbo_stream
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.turbo_stream
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.permit(:comment_body)
    end

    def set_blog
      @blog = Blog.find(params[:blog_id])
    end

    def get_commentable
      return Comment.find(params[:comment_id])
    end

end
