class SessionsController < ApplicationController
  before_action :require_logged_in, only: [:destroy]
  before_action :require_logged_out, only: [:new, :create]

    def new
        render :new 
    end

    def create
        user = User.find_by_credentials(params[:user][:username], params[:user][:password])
        session[:session_token] = user.reset_session_token!
        redirect_to cats_url
    end

    def destroy
      if current_user
        current_user.reset_session_token!
        session[:session_token] = nil
      end
    end
end
