class MoviesController < ApplicationController

	before_filter :load_videoable, :authenticate_user!

	def index
		@videos = @videoable.movies	
	end

	def new
		@video = @videoable.movies.new
	end

	def create
		@video = @videoable.movies.new(params[:movie])
		if @video.save
			redirect_to @videoable, notice: "Movie created"
		else
			render :new
		end
	end

	def destroy
		@video = Movie.find(params[:id])
		@videoable = @video.videoable

		if @video.destroy
			redirect_to @videoable, notice: "video deleted."	
		end
	end

	private

	def load_videoable
		resource, id = request.path.split('/')[1,2]
		@videoable = resource.singularize.classify.constantize.find(id) 
	end
end
