class UsersController < ApplicationController
  #before_action :authorize

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @collections = @user.collections

  end

  def create
    @user = User.new(user_params)
  if @user.save
    session[:user_id] = @user.id
    redirect_to user_steps_path
    #'/after_signup/:id(.:format)'
  else
    render '/new'
  end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :bust, :waist, :hips, :name)
  end

end
