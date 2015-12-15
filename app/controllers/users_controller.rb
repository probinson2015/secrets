class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]

  def new
  end

  def show
  	@user = User.find_by(id: params[:id])
  end

  def create
        @user = User.new(name: params[:Name], email: params[:Email], password: params[:Password])
        if @user.save == true
            session[:user_id] = @user.id
            redirect_to "/users/#{@user.id}"
        else
            flash[:errors] = @user.errors.full_messages
            redirect_to '/users/new'
        end
    end

    def edit
      # render json: params
      @user= User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if !@user.update(name: params[:Name], email: params[:Email], password: params[:Password])   
        # render json: @user
        flash[:errors] = @user.errors.full_messages
        redirect_to "/users/#{@user.id}/edit"
      else
        flash[:success] = "Account updated successfully"
        redirect_to "/users/#{@user.id}"
      end 
    end

    def destroy
      User.find(params[:id]).destroy
      session.clear
      redirect_to '/sessions/new'
    end
end
