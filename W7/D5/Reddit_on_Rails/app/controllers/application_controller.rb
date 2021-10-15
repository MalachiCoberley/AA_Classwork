class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def require_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def require_logged_out
    redirect_to users_url if logged_in?
  end

  def login(user)
    session[:session_token] = user.reset_session_token!
    redirect_to users_url
  end

  def logged_in?
    !!current_user
  end

  def logout
    current_user.reset_session_token!
    session[:session_token] = nil
    @current_user = nil
  end

  def require_moderator
    current_sub = Sub.find(params[:id])
    redirect_to subs_url unless (logged_in? && @current_user.id == current_sub.moderator_id)
  end

end
