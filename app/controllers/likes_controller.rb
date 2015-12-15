class LikesController < ApplicationController
	before_action :require_login, only: [:create, :destroy]
  def create
  	Like.create(secret: Secret.find(params[:secret_id]), user: User.find(current_user.id))
  	redirect_to "/secrets"
  end

  def destroy
  	like = Like.find_by(user: current_user.id, secret: params[:secret_id])
  	like.delete
  	redirect_to "/secrets"
  end
end