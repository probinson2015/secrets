class SecretsController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy]

  def index
  	@secrets = Secret.all
  	# render json: @secrets
  end

  def create
	@user = User.find_by(:id => params[:id])
	secret = Secret.new(:user_id => @user.id, content: params[:content])
   	if secret.valid?
   		secret.save
	else
		flash[:errors] = @secret.errors.full_messages
	end
	redirect_to "/users/#{@user.id}"
  end

  def destroy
  	# @user = User.find(session[:user_id])
  	secret = Secret.find(params[:id])
  	secret.destroy if secret.user == current_user
  	redirect_to "/users/#{current_user.id}"
  end

  # added to likes controller
  # def like
  #   Like.create(:secret_id => params[:secret_id], :user_id => current_user.id)
  #   redirect_to "/secrets"
  # end

  # def unlike
  #   # render json: params
  #   Like.find_by(:secret_id => params[:secret_id], :user_id => current_user.id).destroy
  #   redirect_to "/secrets"
  # end
end
