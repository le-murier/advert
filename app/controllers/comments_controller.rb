class CommentsController < ApplicationController

  def show
    @comment = Comment.find(params[:id])
    render json: @comment, status: :ok
  end

  def create
    @user = User.find(get_id)
    @advert = Advertisement.find(params[:advertisement_id])
    if @advert.status != Status::DRAFT
      @comment = @user.comments.create(advert_params)
        render json: { message: "Comment was created", id: @comment.id },
         status: :created if @comment.valid?
        render json: { error: "Invalid data" }, status: :bad_request
    else
      render json: { error: "Invalid data" }, status: :not_found
    end
  end

  def update
    @id = params[:id]
    @comment = Comment.find(@id)
    if created_by_user(AppComponent::COMMENT, @id)
      @comment.update(content: params[:content])
      render json: { message: "Comment was updated" }, status: :ok
    else
      render json: { error: "Wrong permission" }, status: :forbidden
    end
  end

  def delete
    @id = params[:id]
    @comment = Comment.find(@id)
    if created_by_user(AppComponent::COMMENT, @id)
      @comment.destroy
      render json: { message: "Comment was destroyed" }, status: :ok
    else
      render json: { error: "Wrong permission" }, status: :forbidden
    end
  end

  private

  def advert_params
    advert_data = {
      content: params[:content],
      advertisement_id: params[:advertisement_id]
    }
  end
end
