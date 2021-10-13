class SessionsController < ApplicationController
  before_action :require_no_user!, only: %i(create new)

  def create
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    if user
      login_user!(user)
      redirect_to bands_url
    else
        flash.now[:errors] = ["Invalid password and/or username"]
        render :new
    end
  end

  def new
    render :new
  end


  def destroy
    logout_user!
    redirect_to new_session_url
  end

end
