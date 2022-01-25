class AdvertisementsController < ApplicationController
  #before_action :authorized,
  #only: [:show, :show_id, :show_admins, :update, :delete]

  # SHOW ALL advert
  def show
    #scope :readible, -> { where("status != draft") }
    #@advertisements = Advertisement.readible
    @advertisements = Advertisement.where(status: "publicated")
    render json:  @advertisements, status: 200
  end

  # SHOW advert by id
  def show_id
    @advert = Advertisement.find(params[:id])
    if @advert && @advert.status != "draft"
      render json: {
          title: @advert.title,
          content: @advert.content,
          username: User.find(@advert.user_id).user_name,
          views: @advert.views,
      },  status: 200
    else
      render json: { message: "Invalid input" }, status: 404
    end
  end

  # CREATE advert
  def create
    @advert = Advertisement.create(advert_params(0))
    if @advert.valid?
      render json: { message: "Advertisement was created" }, status: 200
    else
      render json: { error: "Invalid data" }, status: 404
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
      render json: { message: "Advertisement was updated" }, status: 404
    else
      render json: { message: "Wrong params" }, status: 404
    end
  end

  # DELETE advert
  def delete
    @advert = Advertisement.find(params[:id])
    if belongs_to_user(params[:id]) != 0
      @advert.destroy
      render json: { message: "Advertisement was destroyed" }, status: 200
    else
      render json: { message: "Acces denied" }, status: 404
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

  def belongs_to_user(id)
    @advert = Advertisement.find(id)
    @user = User.find(params[:user_id])
    @result = 0
    if @advert.user_id.to_s == params[:user_id] && @user.role != "admin"
      @result = 1
    elsif @user.role == "admin"
      @result = 2
    end
    @result
  end
end
