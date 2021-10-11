class UsersController < ApplicationController
  
  before_action :require_logged_out, only: [:new, :create]


  def new 
    render :new 
  end

  def create
    user = User.new(user_params)
    if user.save
      user.password = user_params[:password]
      redirect_to cats_url
    else
      redirect_to new_session_url
    end
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
