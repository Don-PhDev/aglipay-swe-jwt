require "rails_helper"

RSpec.describe Category, type: :model do
  describe "associations" do
    it { should have_many(:products) }
  end

  # Validations
  let(:name) { 'dairy' }
  let(:subject) do
    build(:category, name: name)
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
