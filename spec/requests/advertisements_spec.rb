require 'rails_helper'
require 'json'
require_relative 'requests_const'
@draft_id = 2

RSpec.describe Advertisement, type: :request do
  it "Show drafts admin only" do
    refresh_header
    get "/advertisements/drafts",
    :params => {}, :headers => @headers
    expect(response).to have_http_status(:ok)
  end

  it "Don't show draft advertisement" do
    @headers = { "ACCEPT" => "application/json",
     "Authorization" => "Bearer #{USER_TOKEN}" }
    get "/advertisements/#{@draft_id}",
    :params => {}, :headers => @headers
    expect(response).to have_http_status(:ok)
  end

  it "Can't get comments for draft" do
    get "/advertisements/#{@draft_id}/comments",
    :params => {}, :headers => @headers
    expect(response).to_not have_http_status(:ok)
  end

  def refresh_header
    @headers = { "ACCEPT" => "application/json",
     "Authorization" => "Bearer #{ADMIN_TOKEN}" }
  end
end
