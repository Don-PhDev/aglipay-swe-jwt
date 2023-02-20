require "rails_helper"

RSpec.describe Product, type: :model do
  describe "associations" do
    it { should belong_to(:category) }
    it { should have_many(:orders) }
  end

  # Validations
  let(:name) { 'Milk' }
  let(:subject) do
    build(:product, name: name)
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  context 'when name is empty' do
    let(:name) { '' }
    it "is not valid" do
      expect(subject).to_not be_valid
    end
  end
end
