class CommentsController < ApplicationController

  def show
    @comment = Comment.find(params[:id])
    render json: @comment, status: :ok
  end

  def create
    @comment = Comment.create(advert_params)
    if @comment.valid?
      render json: { message: "Comment was created", id: @comment.id }, status: :created
    else
      render json: { error: "Invalid data" }, status: :bad_request
    end
  end

  def update
    @id = params[:id]
    @comment = Comment.find(@id)
    if created_by_user(Object::COMMENT, @id)
      @comment.update(content: params[:content])
      render json: { message: "Comment was updated" }, status: :ok
    else
      render json: { error: "Wrong permission" }, status: :forbidden
    end
  end

  def delete
    @id = params[:id]
    @comment = Comment.find(@id)
    if created_by_user(Object::COMMENT, @id)
      @comment.destroy
      render json: { message: "Comment was destroyed" }, status: :ok
    else
      render json: { error: "Wrong permission" }, status: :forbidden
    end
  end

  private

  def advert_params
    advert_data = {
        adverb_id: params[:adverb_id],
        content: params[:content],
        user_id: get_id,
    }
  end
end
