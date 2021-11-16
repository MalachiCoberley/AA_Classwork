class Api::SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user.nil?
      render json: ["User does not exist"], status: 401
    else
      login!(@user)
      render "api/users/show"
    end
  end

  def destroy
    logout!
    render json: ["Logout successful"]
  end
  
end
