class UsersController < ApplicationController
  after_initialize #set the token if it hasn't been set

  def new 
    render :new 
  end

  def create

  end

  
end
