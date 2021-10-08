class CommentsController < ApplicationController

  def index
    # debugger
    # subject = get_subject
    if params[:user_id]
      comments = Comment.where(author_id: params[:user_id])
    elsif params[:artwork_id]
      comments = Comment.where(artwork_id: params[:artwork_id])
    else
      comments = Comment.all
    end
    render json: comments
  end
  
  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment
    else
      render json: comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    comment = get_comment
    comment.destroy
    render json: comment
  end

  private
  def get_comment
    Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :author_id, :artwork_id)
  end

  # def get_subject
  #   params.key?(:user_id) ? User.find(params[:user_id]) : Artwork.find(params[:artwork_id])
  # end

end
