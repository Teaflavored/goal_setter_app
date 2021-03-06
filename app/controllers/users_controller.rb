class UsersController < ApplicationController
  before_action :redirect_unless_logged_in, only: :show
  before_action :redirect_if_logged_in, only: [:new, :create]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      sign_in(@user)
      redirect_to root_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  def show
    @user = User.find(params[:id])
    @goals = @user.goals
    @comments = @user.comments
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
  
  def redirect_unless_logged_in
    redirect_to new_session_url unless logged_in?
  end
end
