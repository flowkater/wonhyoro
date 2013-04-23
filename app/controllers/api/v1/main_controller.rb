# encoding: UTF-8
class Api::V1::MainController < ApplicationController
	respond_to :json
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
end