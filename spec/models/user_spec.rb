require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
         described_class.new(user_name: "newTestUser",
                             email: "testUser123@gmail.com",
                             password: "some_password",
                             role: "user")
  }

  it "params should be not nil" do
      subject.email = nil
      subject.user_name = nil
      subject.password = nil
      expect(subject).to_not be_valid
  end

  it "user_name should be unique" do
      subject.user_name = "testUser0"
      expect(subject.id).to eq(nil)
  end
end
