class UsersController < ApplicationController

  before_action :authorized, only: [:auto_login]

  # REGISTER
  def create
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: {error: "Invalid user_name or password"}
    end
  end

  # LOGGING IN
  def login
    @user = User.find_by(user_name: params[:user_name])
    @s_password = params[:password_digest]
    if @user && @s_password == @user.password_digest
      token = encode_token({user_id: @user.id})
      if token == get_token
        render json: {user: @user, token: token}
      else
        render json: {error: "Invalid token getted"}
      end
    else
      render json: {error: "Invalid user_name or password"}
    end
  end


  def auto_login
    render json: @user
  end

  private

  def user_params
    params.permit(:user_name, :email, :password_digest, :role)
  end
end
