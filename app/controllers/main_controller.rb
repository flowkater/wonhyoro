class MainController < ApplicationController
	before_filter :authenticate_user!

  def dashboard
  		if App.first.blank?
  			redirect_to new_app_path
  		end
  end
end
