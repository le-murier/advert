require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject {
    described_class.new(
      advertisement_id: 3,
      content: "TEST COMMENT TEST COMMENT",
      user_id: 2)
  }

  it "comment will not be created without token" do
      expect(subject).to_not be_valid
  end
end
