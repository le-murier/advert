class AdvertisementsController < ApplicationController
  before_action :authorized,
  only: [:show_id, :create, :update, :delete, :show_draft, :show_comments]

  # SHOW ALL advert
  def show
      @advertisements = Advertisement.where(status: "publicated")
      @sorting_value = params[:sort]
      if @sorting_value == "title"
        render json:  @advertisements.order("title DESC"), status: 200
      elsif @sorting_value == "date"
        render json:  @advertisements.order("created_at DESC"), status: 200
      elsif @sorting_value == "views"
        render json:  @advertisements.order("views DESC"), status: 200
      else
        render json:  @advertisements, status: 200
      end
  end

  # SHOW advert by id
  def show_id
    if params[:id] != "drafts"
      @advert = Advertisement.find(params[:id])
      if @advert && @advert.status != "draft"
        add_view(params[:id])
        render json: {
            title: @advert.title,
            content: @advert.content,
            username: User.find(@advert.user_id).user_name,
            views: @advert.views,
        },  status: 200
      else
        render json: { message: "Invalid input" }, status: 400
      end
    else
      show_draft
    end
  end

  # CREATE advert
  def create
    @advert = Advertisement.create(advert_params(0))
    if @advert.valid?
      render json: { message: "Advertisement was created" }, status: 201
    else
      render json: { error: "Invalid data" }, status: 400
    end
  end

  # Update advert
  def update
    @advert = Advertisement.find(params[:id])
    case belongs_to_user(params[:id])
    when 1
      @advert.update(advert_params(1))
    when 2
      @advert.update(advert_params(2))
    end
    if @advert.valid?
      render json: { message: "Advertisement was updated" }, status: 200
    else
      render json: { message: "Wrong params" }, status: 400
    end
  end

  # DELETE advert
  def delete
    @advert = Advertisement.find(params[:id])
    if belongs_to_user(params[:id]) != 0
      @views = View.where(advert_id: params[:id])
      @views.find_each do |view|
        view.destroy
      end
      @advert.destroy
      render json: { message: "Advertisement was destroyed" }, status: 200
    else
      render json: { message: "Wrong permition" }, status: 403
    end
  end

  # SHOW drafts admin only
  def show_draft
    @id = decoded_token[0]['user_id']
    if User.find(@id).role == "admin"
      @advertisements = Advertisement.where(status: "draft")
      render json: @advertisements, status: 200
    else
      render json: { message: "Wrong permition" }, status: 403
    end
  end

  # SHOW comments to the article
  def show_comments        #1 page = 10 comments
    @page = params[:page]  #comments/?page=:npage
    if Advertisement.find(params[:id]).status != "draft"
      if @page != nil
        @comments = Comment.where(adverb_id: params[:id]).limit(10).offset((@page.to_i-1) * 10)
      else
        @comments = Comment.where(adverb_id: params[:id]).limit(10).offset(0)
      end
      render json: @comments, status: 200
    else
      render json: { message: "Wrong permition" }, status: 403
    end
  end

  private

  def advert_params(status)
    case status
    when 0
      advert_data = {
        title: params[:title],
        content: params[:content],
        user_id: params[:user_id],
        status: "draft",
        views: 0,
      }
    when 1
      advert_data = {
        title: params[:title],
        content: params[:content],
      }
    when 2
      advert_data = {
        status: params[:status],
      }
    end
  end

  #Add views to advert
  def add_view(advert_id)
    @user_watch = decoded_token[0]['user_id']
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

  def belongs_to_user(id)
    @advert = Advertisement.find(id)
    @id = decoded_token[0]['user_id']
    @user = User.find(@id)
    @result = 0
    if @advert.user_id.to_s == params[:user_id] && @user.role != "admin"
      @result = 1
    elsif @user.role == "admin"
      @result = 2
    end
    @result
  end
end
