class AdvertisementsController < ApplicationController
  before_action :authorized,
  only: [:show_id, :create, :update, :delete, :show_drafts, :show_comments]

  def show
      @advertisements = Advertisement.where(status: Status::PUBL)
      case @sorting_value = params[:sort]
      when Sorting::TITLE
        render json: @advertisements.order("#{Sorting::TITLE} DESC"), status: :ok
      when Sorting::DATE
        render json: @advertisements.order("created_at DESC"), status: :ok
      when Sorting::VIEWS
        render json: @advertisements.order("#{Sorting::VIEWS} DESC"), status: :ok
      else
        render json: @advertisements, status: :ok
      end
  end

  def show_id
    @id = params[:id]
    if @id != "drafts"
      render_advert(@id)
    else
      show_drafts
    end
  end

  def create
    @user = User.find(get_id)
    @advert = @user.advertisements.create(advert_params)
    if @advert.valid?
      render json: { message: "Advertisement was created", id: @advert.id }, status: :created
    else
      render json: { error: "Invalid data" }, status: :bad_request
    end
  end

  def update
    @id = params[:id]
    @advert = Advertisement.find(@id)
    @user = User.find(get_id)
    @advert.update(update_params(@user.role)) if created_by_user(AppComponent::ADVERT, @id)
    if @advert.valid?
      render json: { message: "Advertisement was updated" }, status: :ok
    else
      render json: { message: "Wrong params" }, status: :bad_request
    end
  end

  def delete
    @id = params[:id]
    @advert = Advertisement.find(@id)
    if created_by_user(AppComponent::ADVERT, @id)
      @advert.destroy
      render json: { message: "Advertisement was destroyed" }, status: :ok
    else
      render json: { message: "Wrong permition" }, status: :forbidden
    end
  end

  def show_drafts
    @id = get_id
    if User.find(@id).role == Role::ADMIN
      @advertisements = Advertisement.where(status: Status::DRAFT)
      render json: @advertisements, status: :ok
    else
      render json: { message: "Wrong permition" }, status: :forbidden
    end
  end

  def render_advert(id)
    @advert = Advertisement.find(id)
    @user = User.find(get_id)
    if @advert.status != Status::DRAFT || @user.role == Role::ADMIN
      add_view(id)
      render json: {
          title: @advert.title,
          content: @advert.content,
          username: User.find(@advert.user_id).user_name,
          views_number: @advert.views_number,
      },  status: 200
    else
      render json: { message: "Invalid input" }, status: :bad_request
    end
  end

  def show_comments
    @id = params[:id]
    @page = params[:page]
    if Advertisement.find(params[:id]).status != Status::DRAFT
      if @page != nil
        @comments = Comment.where(advertisement_id: @id).limit(RENDERED_PAGE).offset((@page.to_i-1) * RENDERED_PAGE)
      else
        @comments = Comment.where(advertisement_id: @id).limit(RENDERED_PAGE).offset(0)
      end
      render json: @comments, status: :ok
    else
      render json: { message: "Wrong permission" }, status: :not_found
    end
  end

  private

  def advert_params
    advert_data = {
      title: params[:title],
      content: params[:content],
      status: "draft",
      views_number: 0
    }
  end

  def update_params(role)
    advert_data = case role
    when Role::ADMIN
      { status: params[:status] }
    when Role::USER
      { title: params[:title], content: params[:content] }
    else
      {}
    end
  end

  def add_view(advertisement_id)
    @user = User.find(get_id)
    @advert = Advertisement.find(advertisement_id)
    @view = View.find_by(advertisement_id: advertisement_id, user_id: @user.id)
    if @view
      @view.update(number: @view.number + 1)
    else
      @view = @advert.views.create(user_id: @user.id)
      @advert.update(views_number: @advert.views_number + 1)
    end
  end
end
