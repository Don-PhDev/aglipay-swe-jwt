require "rails_helper"

RSpec.describe Order, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:product) }
  end

  describe "validations" do
    it { should validate_presence_of(:quantity) }
  end

  # Validations
  let(:quantity) { 10 }
  let(:subject) do
    build(:order, quantity: quantity)
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  context 'when quantity is zero' do
    let(:quantity) { 0 }
    it "is not valid" do
      expect(subject).to_not be_valid
    end
  end
end
