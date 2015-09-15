class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :destroy, :update]
  before_action :authenticate_user!, only: [:profile, :destroy, :edit, :update]

  def index
  	@users = User.all
  end

  def new
  	@user = User.new
  end

  def show
  end

  def edit
  end

  def profile
  	@user = current_user
  	render :show
  end

  def create
  	@user = User.create(user_params)
  	session[:user_id] = @user.id
  	redirect_to @user, notice: "New account created!"
  end

  def update
  	@user.update(user_params)
  	redirect_to @user, notice: "Account updated!"
  end

  def destroy
  	@user.destroy
  	session[:user_id] = nil if @user == current_user
  	redirect_to users_path, notice: "User account was deleted."
  end

  private

  def user_params
  	params.require(:user).permit(:username, :email, :password, :location, :bio)
  end

  def set_user
  	begin
  		@user = User.find(params[:id])
  	rescue
  		flash[:notice] = "That user could not be found."
  		redirect_to users_path
  	end
  end
end
