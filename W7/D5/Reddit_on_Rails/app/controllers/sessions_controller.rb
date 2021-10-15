class SessionsController < ApplicationController
  before_action :require_logged_in, only: [:index, :show]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    if @user
      login(@user)
    else
      render :new
    end
  end

  def destroy
    current_user.reset_session_token! if logged_in?
    session[:session_token] = nil
    redirect_to new_session_url
  end
end
