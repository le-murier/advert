class AdvertisementsController < ApplicationController
  before_action :authorized,
  only: [:show_id, :create, :update, :delete, :show_draft, :show_comments]

  def show
      @advertisements = Advertisement.where(status: Status::PUBL)
      case @sorting_value = params[:sort]
      when Sorting::TITLE
        render json: @advertisements.order("#{Sorting::TITLE} DESC"), status: :ok
      when Sorting::DATE
        render json: @advertisements.order("created_at DESC"), status: :ok
      when Sorting::VIEWS
        render json:  @advertisements.order("#{Sorting::VIEWS} DESC"), status: :ok
      else
        render json:  @advertisements, status: :ok
      end
  end

  def show_id
    @id = params[:id]
    if @id != "drafts"
      render_advert(@id)
    else
      show_drafts()
    end
  end

  def create
    @advert = Advertisement.create(advert_params)
    if @advert.valid?
      render json: { message: "Advertisement was created" }, status: :created
    else
      render json: { error: "Invalid data" }, status: :bad_request
    end
  end

  def update
    @id = params[:id]
    @advert = Advertisement.find(@id)
    @user = User.find(get_id)
    @advert.update(update_params(@user.role)) if created_by_user(Object::ADVERT, @id)
    if @advert.valid?
      render json: { message: "Advertisement was updated" }, status: :ok
    else
      render json: { message: "Wrong params" }, status: :bad_request
    end
  end

  def delete
    @id = params[:id]
    @advert = Advertisement.find(@id)
    if created_by_user(Object::ADVERT, @id)
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
    if @advert && @advert.status != Status::DRAFT
      add_view(id)
      render json: {
          title: @advert.title,
          content: @advert.content,
          username: User.find(@advert.user_id).user_name,
          views: @advert.views,
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
        @comments = Comment.where(adverb_id: @id).limit(RENDERED_PAGE).offset((@page.to_i-1) * RENDERED_PAGE)
      else
        @comments = Comment.where(adverb_id: @id).limit(RENDERED_PAGE).offset(0)
      end
      render json: @comments, status: :ok
    else
      render json: { message: "Wrong permition" }, status: :forbidden
    end
  end

  private

  def advert_params()
      advert_data = {
        title: params[:title],
        content: params[:content],
        user_id: get_id,
        status: "draft",
        views: 0,
      }
  end

  def update_params(role)
    case role
    when Role::ADMIN
      advert_data = {
        status: params[:status],
      }
    when Role::USER
      advert_data = {
        title: params[:title],
        content: params[:content],
      }
    end
  end

  def add_view(advert_id)
    @user_watch = get_id
    @advert = Advertisement.find(advert_id)
    @view = View.find_by(advert_id: advert_id, user_id: @user_watch)
    if @view
      @view.update(number: @view.number + 1)
    else
      @view = View.create({
        advert_id: advert_id,
        user_id: @user_watch,
      })
      @advert.update(views: @advert.views + 1)
    end
  end
end
