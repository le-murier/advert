require 'rails_helper'
require 'json'

RSpec.describe Advertisement, type: :request do
  subject {
    described_class.new(
      title: "New cool advertisement 2.0",
      content: "HELLO ALL I WANNA TO SELL A CAR, AND CARROT")
  }

  it "Advert functionality" do
    @headers = { "ACCEPT" => "application/json",
      "Authorization" => "Bearer #{@user_token}" }
    create_advert && delete_advert
  end

  def create_advert
    post "/advertisements",
    :params => {
      :title => subject.title,
      :content => subject.content,
    },
     :headers => @headers
    @advertisement_id = JSON.parse(response.body)["id"]
    expect(response).to have_http_status(:created)
  end

  def delete_advert
    delete "/advertisements/#{@advertisement_id}", :headers => @headers
    expect(response).to have_http_status(:ok)
  end
end
