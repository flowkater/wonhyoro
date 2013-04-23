# encoding: UTF-8
class NotisController < ApplicationController
	before_filter :authenticate_user!
	def index
		@notis = Noti.all
	end

	def new
		@noti = Noti.new
	end

	def create
		@noti = Noti.new(params[:noti])

		if @noti.save
			redirect_to notis_path, notice: "공지가 만들어졌습니다."
		else
			render 'new'
		end
	end

	def push
		@noti = Noti.find(params[:id])
		redirect_to notis_path, notice: "푸쉬를 보냈습니다."
	end
end