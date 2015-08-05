class SessionsController < ApplicationController
  include SessionsHelper
  skip_before_filter :require_login

  def new
  	if signed_in?
  		redirect_to '/dashboard'
  	else
  		render 'new'
  	end
  end

  def create
  	user = User.authenticate(params[:session][:email],
	params[:session][:password])
	if user.nil? || user.deleted == 1
		flash.now[:error] = "المعلومات التي قمت بإدخالها غير صحيحة."
		render 'new'
	else
		sign_in user
		redirect_to "/dashboard"
	end
  end

  def destroy
	sign_out
	redirect_to root_path
  end
end
