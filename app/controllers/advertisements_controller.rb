class AdvertisementsController < ApplicationController
  before_action :authorized, only: []

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
    @username = User.find(@advert.user_id).user_name
    render json: { title: @advert.title,
      content: @advert.content,
      username: @username,
      views: @advert.views }, status: 200
  end
end
