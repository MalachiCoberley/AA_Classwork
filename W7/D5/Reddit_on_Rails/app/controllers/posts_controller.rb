class PostsController < ApplicationController
    # before_action :require_author, only: [:update, :edit]

    def show
        @post = Post.find(params[:id])
        render :show
    end
    
    def new
        @post = Post.new
        render :new
    end

    def create
        @post = Post.new(post_params)
        @post.author_id = current_user.id
        @post.sub_id = params[:id]
        if @post.save
          redirect_to sub_url(@post)
        else
          flash.now[:errors] = @post.errors.full_messages
          render :new
        end
      end
    
      def edit
        @posts = current_user.posts
        @post = @posts.where(id: params[:id]).first
        if @post.nil?
          redirect_to subs_url
        else
          render :edit
        end
      end
    
      def update
        @posts = current_user.posts
        @post = @posts.where(id: params[:id]).first
        if @post.update_attributes(post_params)
          redirect_to post_url(@post)
        else
          flash.now[:errors] = @post.errors.full_messages
          render :edit
        end
      end
    
      private
    
      def post_params
        params.require(:posts).permit(:title, :url, :content)
      end






end
