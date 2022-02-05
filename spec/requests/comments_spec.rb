require 'rails_helper'
require 'json'
@comment_id = -1

RSpec.describe Advertisement, type: :request do #працює, але треба уточнити
  subject {
    described_class.new(
      advertisement_id: @advertisement_id,
      content: "HELLO ALL I WANNA TO SELL A CAR, AND CARROT"
    )
  }

  it "Comment functionality" do
    create_comment && delete_comment
  end

  def create_comment
    post "/advertisements",
    :params => {
      :advertisement_id => subject.advertisement_id,
      :content => subject.content,
    },
     :headers => @headers
    @comment_id = JSON.parse(response.body)["id"]
    expect(response).to have_http_status(:created)
  end

  def delete_comment
    delete "/comments/#{@comment_id}", :headers => @headers
    expect(response).to have_http_status(:ok)
  end
end
