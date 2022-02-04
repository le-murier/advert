require 'rails_helper'
require 'json'
require_relative 'requests_const'

RSpec.describe User, type: :request do #працює
  subject {
    described_class.new(
      user_name: "tstuser4",
      email: "tstuse54r@gmail.com",
      password: "iamaaa123")
  }

  it "User functionality" do
    create_user && loggin_user && delete_user
  end

  def create_user
    post "/users",
    :params => {
      :user_name => subject.user_name,
      :email => subject.email,
      :password => subject.password
    },
     :headers => @headers
    expect(response).to have_http_status(:created)
  end

  def loggin_user
    post "/login",
    :params => {
      :user_name => subject.user_name,
      :password => subject.password
    },
     :headers => @headers
    @user_token = JSON.parse(response.body)["token"]
    @user_id = JSON.parse(response.body)["id"]
  end

  def delete_user
    @headers = { "ACCEPT" => "application/json",
      "Authorization" => "Bearer #{@user_token}" }
    delete "/users/#{@user_id}", :headers => @headers
    expect(response).to have_http_status(:ok)
  end
end
