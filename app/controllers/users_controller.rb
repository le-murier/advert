class UsersController < ApplicationController

  def login
    
  end
=begin
  def show
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new({
          user_name: params[:user_name],
          email: params[:email],
          password: params[:password],
          admin: params[:admin]
      })
    if @user.save
      render json: @user
    else
      render error: {error: "Unable to create a user"}, status: 400
    end
  end

  def delete
    @user = User.find(params[:id])
    @user.destroy
    render json: {message: "User was destroyed"}, status: 200
  end
=end
end
