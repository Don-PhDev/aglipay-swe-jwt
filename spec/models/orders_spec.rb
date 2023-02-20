require "rails_helper"

RSpec.describe Order, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:product) }
  end

  describe "validations" do
    it { should validate_presence_of(:quantity) }
  end
end
