class UsersController < ApplicationController
  before_action :authorized,
  only: [:show, :show_id, :show_admins, :update, :delete]

  def show
    @users = User.all
    render json: @users, status: :ok
  end

  def show_id
    @user = User.find(params[:id])
    render json: @user, status: :ok
  end

  def show_admins
    @user = User.find(get_id)
    if @user.role == Role::ADMIN
      @admins =  User.find_by(role: Role::ADMIN)
      render json:  @admins, status: :ok
    else
      render json: { message: "Wrong user rights" }, status: :forbidden
    end
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      render json: { message: "User was created" }, status: :created
    else
      render json: { error: "Invalid data" }, status: :bad_request
    end
  end

  def login
    @user = User.find_by(user_name: params[:user_name])
    @s_password = params[:password]
    if @user && BCrypt::Password.new(@user.password_digest) == @s_password
      token = encode_token({ user_id: @user.id })
      @user.update(token: token)
      render json: { token: token, id: @user.id }, status: :ok
    else
      render json: { error: "Invalid username or password" },
       status: :bad_request
    end
  end

  def update
    @id = params[:id].to_i
    @user = User.find(params[:id])
    @token_user = User.find(get_id)
    if created_by_user(Object::USER, @id)
      @update_json = update_params(@token_user.role)
      @user.update(@update_json)
      render json: { message: "User was updated" }, status: :ok
    else
      render json: { message: "Wrong user rights" }, status: :forbidden
    end
  end

  def delete
    @id = params[:id].to_i
    @user = User.find(params[:id])
    if created_by_user(Object::USER, @id)
      @user.destroy
      render json: { message: "User was destroyed" }, status: :ok
    else
      render json: { message: "Wrong user rights" }, status: :forbidden
    end
  end

  def log_out
    @token = get_token()
    @user = User.find_by(token: @token)
    if @token && @user
      @user.update(token: nil)
      render json: { message: "User was logged out" }, status: :ok
    else
      render json: { message: "Wrong user rights" },
       status: :forbidden
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
