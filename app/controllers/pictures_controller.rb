# encoding: UTF-8
class PicturesController < ApplicationController
	before_filter :load_imageable, :authenticate_user!

	def index
		@images = @imageable.pictures
	end

	def new
		@image = @imageable.pictures.new
	end

	def create
		@image = @imageable.pictures.new(params[:picture])
		if @image.save
			redirect_to @imageable, notice: "Picture created."
		else
			render :new
		end
	end

	def destroy
		@image = Picture.find(params[:id])
		@imageable = @image.imageable

		if @image.destroy
			redirect_to @imageable, notice: "Comment deleted."	
		end
	end

	private

	# /events/:event_id/pictures/new => events, :event_id
	# singularize 단수화 classify 클래스화(prefix 대문자) constantize 상수화
	# 여러 모델에 대응되는 이미지를 가져오기 위해
	def load_imageable
		resource, id = request.path.split('/')[1,2]
		@imageable = resource.singularize.classify.constantize.find(id) 
	end
end
