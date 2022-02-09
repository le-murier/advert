require 'rails_helper'
require 'json'
require_relative 'requests_const'

RSpec.describe User, type: :request do #працює
  it "User login" do
    post "/login",
    :params => {
      :user_name => "admin",
      :email => "admin@gmail.com",
      :password => "securepassword789"
    },
     :headers => @headers
    expect(response).to have_http_status(:ok)
  end

  it "Show admins admin only" do
    get "/admins",
    :params => {
      :user_name => "testuser0",
      :password => "securepassword123"
    },
     :headers => @headers
     expect(response).to have_http_status(:unauthorized)
  end
end
