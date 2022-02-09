require 'rails_helper'
require 'json'
require_relative 'requests_const'
@comment_id = -1
@advert_id = 2

RSpec.describe Advertisement, type: :request do
  it "Can not create comment for draft" do
    @headers = { "ACCEPT" => "application/json",
           "Authorization" => "Bearer #{USER_TOKEN}" }
    post '/comments',
    :params => {
      :advertisement_id => 2,
      :content => "I AM COMMENT",
      :user_id => 1,
    },
     :headers => @headers
    expect(response).to have_http_status(:not_found)
  end
end
