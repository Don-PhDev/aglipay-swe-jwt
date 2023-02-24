require 'rails_helper'

RSpec.describe Api::V1::OrdersController, type: :request do
  let!(:order) { create(:order) }

  describe "GET /api/v1/orders" do
    before { get '/api/v1/orders' }

    it "returns orders" do
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /api/v1/orders" do
    let(:user) { build(:user) }
    let(:product) { create(:product) }
    let(:order_params) { { quantity: 2, product_id: product.id } }

    context "when authenticated with valid params" do
      before { sign_in user }

      it "creates a new order" do
        expect {
          post "/api/v1/orders", params: { order: order_params }
        }.to change(Order, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(json["quantity"]).to eq(2)
        expect(json["total_amount"]).to eq(product.price * 2)
      end
    end

    context "when authenticated with invalid params" do
      before { sign_in user }

      let(:order_params) { { quantity: 0, product_id: product.id } }

      it "does not create a new order" do
        expect {
          post "/api/v1/orders", params: { order: order_params }
        }.to change(Order, :count).by(0)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json["errors"]).to include("Quantity must be greater than 0")
      end
    end

    context "when not authenticated" do
      let(:order_params) { { quantity: 2, product_id: product.id } }

      it "returns unauthorized status" do
        post "/api/v1/orders", params: { order: order_params }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when product not found" do
      before { sign_in user }

      let(:order_params) { { quantity: 2, product_id: 0 } }

      it "returns not found status" do
        post "/api/v1/orders", params: { order: order_params }
        expect(response).to have_http_status(:not_found)
        expect(json["error"]).to eq("Product not found")
      end
    end
  end
end
