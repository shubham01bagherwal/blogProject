class LikeController < ApplicationController
	before_action :set_blog, only: %i[ create destroy ]

	def create
		@like = @blog.likes.new
		@like.user_id = @current_user.id
	    respond_to do |format|
			if @like.save
			UserMailer.like_mail(@like.id).deliver_later
	    	format.turbo_stream do 
	    		render turbo_stream: [
	    			turbo_stream.append( 'likes', partial: 'blogs/like_partials', locals: { blog: @blog}),
	    			turbo_stream.update('like_count', html: likes_count.html_safe)
	    		]
	    	end
	    end
    end
	end

	def destroy	
		@like = @blog.likes.find(params[:id])
		respond_to do |format|
			if @like.destroy
				format.turbo_stream do 
	    		render turbo_stream: [
	    			turbo_stream.append( 'likes', partial: 'blogs/like_partials', locals: { blog: @blog}),
	    			turbo_stream.update('like_count', html: likes_count.html_safe)
	    		]	
    		end	    
    	end
    end
	end

	def likes_count
		"<strong>Likes:</strong>
		#{@blog.likes.count}"
	end

	def set_blog
    @blog = Blog.find(params[:blog_id])
  end

end