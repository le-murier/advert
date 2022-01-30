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
    @user = User.find(params[:id])
    if @user.role == "admin"
      @admins =  User.find_by(role: "admin")
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
    @user = User.find(params[:id])
    if @user.token == params[:token]
      @user.update(user_params)
      render json: { message: "User was updated" }, status: 200
    else
      render json: { message: "Wrong user rights" }, status: 403
    end
  end

  # DELETE User
  def delete
    @user = User.find(params[:id])
    if @user.token == params[:token]
      @user.destroy
      render json: { message: "User was destroyed" }, status: 200
    else
      render json: { message: "Wrong user rights" }, status: 403
    end
  end

  def log_out
    @token = params[:token]
    if @token
      @user.update(token: nil)
      render json: { message: "User was logged out" }, status: 200
    else
      render json: { message: "Wrong user rights" }, status: 403
    end
  end

  private

  def user_params
    @valid_password = !!params[:password].match(/^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$/)
    @valid_email = !!params[:email].match(/\A[\w.+-]+@\w+\.\w+\z/)
    if @valid_password && @valid_email
      @password = params[:password]
      @email = params[:email]
    else
      @password = null
      @email = null
    end
      user_data = {
        user_name: params[:user_name],
        email: @email,
        password_digest: BCrypt::Password.create(@password),
        role: params[:role]
      }
  end
end
