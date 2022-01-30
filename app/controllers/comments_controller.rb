tclass CommentsController < ApplicationController

  def show
    @comments = Comment.all
    render json: @comments, status: 200
  end

  def create
    @comment = Comment.create(user_params)
    if @comment.valid?
      render json: { message: "Comment was created" }, status: 201
    else
      render json: { error: "Invalid data" }, status: 400
    end
  end

  def update
    @comment = Comment.find(params[:id])
    @user.update(content: params[:content])
    render json: { message: "User was updated" }, status: 200
  end

  def delete
    @comment = Comment.find(params[:id])
    @comment.destroy
    render json: { message: "Comment was destroyed" }, status: 200
  end

  private

  def advert_params()
    advert_data = {
        adverb_id: params[:adverb_id],
        content: params[:content],
        user_id: params[:user_id],
    }
end
