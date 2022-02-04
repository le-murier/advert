require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    described_class.new(
      user_name: "newtest12",
      email: "testUser123@gmail.com",
      password: "some_password",
      role: "user")
  }

  it "user will be created" do
      expect(subject).to be_valid
  end

  it "user cannot be created" do
      subject.user_name = "NAME12232  "
      subject.email = "uncorrect"
      subject.user_name = "123"
      expect(subject.id).to be(nil)
  end
end
