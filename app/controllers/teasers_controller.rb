# encoding: UTF-8
class TeasersController < ApplicationController
	before_filter :authenticate_user!

	def new
		@event = Event.find(params[:event_id])
		@teaser = @event.teasers.build
	end

	def create
		@event = Event.find(params[:event_id])
		@teaser = @event.teasers.build(params[:teaser])
		if @teaser.save
			redirect_to @event, notice: '티저 생성'
		else
			render action: 'new'
		end
	end

	def show
		@teaser = Teaser.find(params[:id])
		@event = @teaser.event
		@videoable = @imageable = @teaser
		@images = @imageable.pictures
		@image = Picture.new
		@videos = @videoable.movies
		@video = Movie.new
	end

	def edit
		@teaser = Teaser.find(params[:id])
	end

	def update
		@teaser = Teaser.find(params[:id])
		@event = @teaser.event

		if @teaser.update_attributes(params[:teaser])
			redirect_to @event, notice: 'teaser was updated.'
		else
			render action: "edit"
		end
	end

	def destroy
		@teaser = Teaser.find(params[:id])
		@event = @teaser.event
		if @teaser.destroy
			redirect_to @event
		end
	end

	# push 버튼
	def push
		@teaser = Teaser.find(params[:id])	
		@event = @teaser.event
		@teaser.gcm_send
		@event.count_plus

		# PushteasersWorker.perform_async(@teaser.id)

		redirect_to @event, notice: '티저 푸쉬를 보냈습니다.'
	end
end