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
    @id = params[:id]
    @comment = Comment.find(@id)
    if created_by_user(Object::COMMENT, @id)
      @comment.update(content: params[:content])
      render json: { message: "Comment was updated" }, status: 200
    else
      render json: { error: "Wrong permition" }, status: 403
    end
  end

  def delete
    @id = params[:id]
    @comment = Comment.find(@id)
    if created_by_user(Object::COMMENT, @id)
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
        user_id: get_id,
    }
  end
end
