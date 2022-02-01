class UsersController < ApplicationController
  before_action :authorized,
  only: [:show, :show_id, :show_admins, :update, :delete]

  # SHOW ALL Users
  def show
    @users = User.all
    render json: @users, status: 200
  end

  # SHOW User by id
  def show_id
    @user = User.find(params[:id])
    render json: @user, status: 200
  end

  # SHOW all admins
  def show_admins
    @user = User.find(get_id)
    if @user.role == Role::ADMIN
      @admins =  User.find_by(role: Role::ADMIN)
      render json:  @admins, status: 200
    else
      render json: { message: "Wrong user rights" }, status: 403
    end
  end

  # REGISTER
  def create
    @user = User.create(user_params)
    if @user.valid?
      render json: { message: "User was created" }, status: 201
    else
      render json: { error: "Invalid data" }, status: 400
    end
  end

  # LOGGING IN
  def login
    @user = User.find_by(user_name: params[:user_name])
    @s_password = params[:password]
    if @user && BCrypt::Password.new(@user.password_digest) == @s_password
      token = encode_token({ user_id: @user.id })
      @user.update(token: token)
      render json: { token: token }, status: 200
    else
      render json: { error: "Invalid username or password" }, status: 400
    end
  end

  # Update User
  def update
    @id = params[:id]
    @user = User.find(@id)
    @token_user = User.find(get_id)
    @user.update(@token_user.role) if created_by_user(Object::USER, @id)
    if @user.valid?
      render json: { message: "User was updated" }, status: 200
    else
      render json: { message: "Wrong user rights" }, status: 403
    end
  end

  # DELETE User
  def delete
    @id = params[:id]
    @user = User.find(@id)
    if created_by_user(Object::USER, @id)
      @user.destroy
      render json: { message: "User was destroyed" }, status: 200
    else
      render json: { message: "Wrong user rights" }, status: 403
    end
  end

  def log_out
    @token = get_token()
    @user = User.find_by(token: @token)
    if @token && @user
      @user.update(token: nil)
      render json: { message: "User was logged out" }, status: 200
    else
      render json: { message: "Wrong user rights", gh: @user }, status: 403
    end
  end

  private

  def user_params
      user_data = {
        user_name: params[:user_name],
        email: params[:email],
        password: params[:password],
        role: "user",
      }
  end

  def update_params(role)
    case role
    when Role::ADMIN
      advert_data = {
        role: params[:role],
      }
    when Role::USER
      advert_data = {
        user_name: params[:user_name],
        email: params[:email],
        password: params[:password],
      }
    end
  end
end
