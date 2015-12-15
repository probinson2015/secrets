class SessionsController < ApplicationController
  def new
  end  

  def create
  	user = User.find_by(:email => params[:Email])
  	if user && user.authenticate(params[:Password])
  		session[:user_id] = user.id
  		redirect_to "/users/#{user.id}"
  	else
  		flash[:error] = "Invalid credentials"
  		redirect_to '/sessions/new'
  	end
  end

  def delete
    session.clear
    redirect_to '/sessions/new'
  end
end
