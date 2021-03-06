class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create]
  
  def new
    render :new
  end
  
  def create
    @user = User.find_by_credentials(params[:user][:username],
                                     params[:user][:password])
    if @user.nil?
      flash.now[:errors] = ["Invalid Sign In"]
      render :new
    else
      sign_in(@user)
      redirect_to root_url
    end
  end
  
  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end
end
