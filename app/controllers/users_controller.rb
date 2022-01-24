class UsersController < ApplicationController

  before_action :authorized,
   only: [:show, :show_id, :show_admins, :update, :delete]

  # SHOW ALL Users
  def show
    @users = User.all
    render json:  @users, status: 200
  end

  # SHOW User by id
  def show_id
    @user = User.find(params[:id])
    render json: @user, status: 200
  end

  # SHOW all admins
  def show_admins
    @user = User.find(params[:id])
    if @user.role == "admin"
      @admins =  User.find_by(role: "admin")
      render json:  @admins, status: 200
    else
      render json: { message: "Access is denied" }, status: 404
    end
  end

  # REGISTER
  def create
    @user = User.create(user_params)
    if @user.valid?
      render json: { message: "User was created" }, status: 200
    else
      render json: { error: "Invalid data" }, status: 404
    end
  end

  # LOGGING IN
  def login
    @user = User.find_by(user_name: params[:user_name])
    @s_password = params[:password]
    if @user && @s_password == @user.password
      token = encode_token({user_id: @user.id})
      @user.update(token: token)
      render json: { token: token }, status: 200
    else
      render json: { error: "Invalid username or password" }, status: 404
    end
  end

  # Update User
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    render json: { message: "User was updated" }, status: 200
  end

  def test
    @users = User.all
    render json: @users, status: 200
  end

  # DELETE User
  def delete
    @user = User.find(params[:id])
    @user.destroy
    render json: { message: "User was destroyed" }, status: 200
  end

  private

  def user_params
    user_data = {
      user_name: params[:user_name],
      email: params[:email],
      password: BCrypt::Password.create(params[:password_digest]),
      role: params[:role]}
  end
end
