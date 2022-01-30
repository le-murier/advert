class CommentsController < ApplicationController

  def show
    @comment = Comment.find(params[:id])
    render json: @comment, status: 200
  end

  def create
    @comment = Comment.create(advert_params)
    if @comment.valid?
      render json: { message: "Comment was created" }, status: 201
    else
      render json: { error: "Invalid data" }, status: 400
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if belongs_to_user(@comment.user_id)
      @comment.update(content: params[:content])
      render json: { message: "Comment was updated" }, status: 200
    else
      render json: { error: "Wrong permition" }, status: 403
    end
  end

  def delete
    @comment = Comment.find(params[:id])
    if belongs_to_user(@comment.user_id)
      @comment.destroy
      render json: { message: "Comment was destroyed" }, status: 200
    else
      render json: { error: "Wrong permition" }, status: 403
    end
  end

  private

  def advert_params()
    advert_data = {
        adverb_id: params[:adverb_id],
        content: params[:content],
        user_id: decoded_token[0]['user_id'],
    }
  end

  def belongs_to_user(user_id)
    @id = decoded_token[0]['user_id']
    @result = false
    if user_id == @id || User.find(@id).role == "admin"
      @result = true
    end
    @result
  end
end
