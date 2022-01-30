require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users/:id without token" do
    it "works! (now write some real specs)" do
      get "/users/80"
      expect(response).to have_http_status(401)
    end
  end
end
