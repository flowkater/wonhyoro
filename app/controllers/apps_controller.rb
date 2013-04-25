# encoding: UTF-8
class AppsController < ApplicationController

	def new
		@app = App.first
		if @app
			redirect_to @app
		else
			@app = App.new	
		end
	end

	def create
		@app_first = App.first
		@app = App.new(params[:app])
		if @app.save && !@app_first
			redirect_to @app, notice: "버젼명이 생성되었습니다."
		else
			render action: "new"
		end
	end

	def show
		@app = App.first
	end

	def edit
		@app = App.find(params[:id])
	end

	def update
		@app = App.find(params[:id])

		if @app.update_attributes(params[:app])
			redirect_to @app, notice: "app version upgrade."
		else
			render action: "edit"
		end
	end
end