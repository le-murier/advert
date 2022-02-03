class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(payload)
    JWT.encode(payload, 'yourSecret')
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      # header: { 'Authorization': 'Bearer <token>' }
      begin
        JWT.decode(token, 'yourSecret', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def get_token
    token = auth_header.split(' ')[1]
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end

  def created_by_user(object, object_id)
    @current_user_id = get_id
    @current_user = User.find(@current_user_id)
    return true if @current_user.role == Role::ADMIN
    case object
    when Object::USER
      return true if object_id == @current_user_id
    when Object::ADVERT
      @current_advert = Advertisement.find(object_id)
      return true if @current_advert.user_id == @current_user_id
    when Object::COMMENT
      @current_comment = Comment.find(object_id)
      return true if @current_comment.user_id == @current_user_id
    else
      return false
    end
  end

  def get_id
    decoded_token[0]['user_id']
  end

  RENDERED_PAGE = 10

  module Role
    ADMIN = "admin"
    USER = "user"
  end

  module Sorting
    TITLE = "title"
    DATE = "date"
    VIEWS = "views"
  end

  module Status
    PUBL = "publicated"
    DRAFT = "draft"
  end

  module Object
    USER = 1
    ADVERT = 2
    COMMENT = 3
  end
end
