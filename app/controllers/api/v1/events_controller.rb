# encoding: UTF-8
class Api::V1::EventsController < ApplicationController
	before_filter :restrict_access
	respond_to :json

	def index
		@events = Event.all
		render 'events/v1/index'
	end

	private

	def restrict_access
		authenticate_or_request_with_http_token do |token, options|
			ApiKey.exists?(access_token: token)
		end
	end
end