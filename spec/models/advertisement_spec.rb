require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  subject {
    described_class.new(
      title: "newtestuss",
      content: "testUser123@gmail.com",
      user_id: "some_password123")
  }

  it "advert will not be created without token" do
      expect(subject).to_not be_valid
  end
end
