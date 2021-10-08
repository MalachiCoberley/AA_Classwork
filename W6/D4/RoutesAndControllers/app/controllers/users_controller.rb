require 'byebug'


# users GET    /users(.:format)                                  users#index
# POST   /users(.:format)                                        users#create
# new_user GET    /users(.:format)                               users#new
# edit_user GET    /users/:id/edit(.:format)                     users#edit
# PATCH  /users/:id(.:format)                                    users#update
# PUT    /users/:id(.:format)                                    users#update
# DELETE /users/:id(.:format)                                    users#destroy
# user GET    /users/:id(.:format)                               users#show

class UsersController < ApplicationController
  def index
    search = params[:username]
    if search
      users = User.where("LOWER(username) LIKE LOWER(?)", "%#{search}%")
    else
      users = User.all
    end
    render json: users
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
    
  end

  def show
    user = get_user
    render json: user
  end

  def update
    user = get_user
    if user.update(user_params)
      render json: user
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    user = get_user
    user.destroy
    render json: user
  end

  private
  def user_params
    params.require(:user).permit(:username)
  end

  def get_user
    User.find(params[:id])
  end
end
