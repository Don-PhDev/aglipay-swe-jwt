require 'rails_helper'

RSpec.describe Api::V1::OrdersController, type: :request do
  let!(:order) { create(:order) }
  let!(:user) { create(:user) }
  let!(:product) { create(:product) }

  describe "GET /api/v1/orders" do
    before { get '/api/v1/orders' }

    it "returns orders" do
      expect(JSON.parse(response.body)).not_to be_empty
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end
end
