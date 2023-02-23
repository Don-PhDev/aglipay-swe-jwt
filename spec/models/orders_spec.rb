require "rails_helper"

RSpec.describe Order, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:product) }
  end

  describe "validations" do
    let(:quantity) { 2 }
    let(:product) { create(:product, price: 2.00) }
    let(:total_amount) { 4.00 }
    let(:subject) do
      build(:order, product: product, quantity: quantity, total_amount: total_amount)
    end

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    context "when quantity is zero" do
      let(:quantity) { 0 }
      it "is not valid" do
        expect(subject).to_not be_valid
      end
    end

    context "when total_amount is other than the price times quantity" do
      let(:total_amount) { 3.00 }
      it "is not valid" do
        expect(subject).to_not be_valid
      end
    end
  end
end
