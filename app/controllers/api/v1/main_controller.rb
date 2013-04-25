# encoding: UTF-8
class Api::V1::MainController < ApplicationController
  before_filter :restrict_access
	respond_to :json

	# root_path/version_check?version=$
	def version_check
		version = params[:version]
  		@app = App.first
  		
  		if version == @app.version
  			render status: 200, json: {message: "Latest version."}
  		else
  			redner status: 302, json: {message: "Need to upgrade.", url: "#{@app.store_url}"}
  		end
	end

	# root_path/init?reg_id=$
  def init
  		regid = params[:reg_id]

  		if Gcm.find_by_reg_id(regid)
  			render status: 200, json:{response: "Success, already exists."}
  		else
  			Gcm.transaction do
	        begin
	          @gcm = Gcm.create!(reg_id: regid)
	        rescue ActiveRecord::RecordInvalid
	          render status: :unprocessable_entity, json: {response: 'Error'}
	          raise ActiveRecord::Rollback
	        end
	        render status: 200, json:{message: "Register, Success"}
      	end
  		end
  end

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      ApiKey.exists?(access_token: token)
    end
  end
end