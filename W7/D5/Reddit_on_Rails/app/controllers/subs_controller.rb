class SubsController < ApplicationController
  before_action :require_moderator, only: [:create, :edit]

  def index
    @subs = Subs.all
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @subs = current_user.subs
    @sub = @subs.where(id: params[:id]).first
    if @sub.nil?
      redirect_to subs_url
    else
      render :edit
    end
  end

  def update
    @subs = current_user.subs
    @sub = @subs.where(id: params[:id]).first
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  private

  def sub_params
    params.require(:subs).permit(:title, :description)
  end

end
