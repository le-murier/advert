class UsersController < ApplicationController

  before_action :authorized, only: [:auto_login]

  # REGISTER
  def create
    @user = User.create(user_params)
    if @user.valid?
      render json: { message: "User was created" }
    else
      render json: { error: "Invalid data" }
    end
  end

  # LOGGING IN
  def login
    @user = User.find_by(user_name: params[:user_name])
    @s_password = params[:password]
    if @user && @s_password == @user.password
      token = encode_token({user_id: @user.id})
      @user.update(token: token)
      render json: { token: token }
    else
      render json: { error: "Invalid user_name or password" }
    end
  end

  def test
    @users = User.all
    render json: @users
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
