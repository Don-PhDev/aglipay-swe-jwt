RSpec.describe Api::V1::OrdersController, type: :request do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let!(:order) { create(:order) }

  describe "GET /api/v1/orders" do
    before { get "/api/v1/orders" }

    it "returns orders" do
      expect(response).to be_successful
      expect(response.body).not_to be_empty
      expect(response.parsed_body.size).to eq(1)
    end
  end

  describe "POST /api/v1/orders" do
    let(:order_params) { { quantity: 2, product_id: product.id } }

    context "when authenticated with valid params" do
      before { sign_in user }

      it "creates a new order" do
        expect {
          post "/api/v1/orders", params: { order: order_params }
        }.to change(Order, :count).by(1)

        expect(response).to be_successful
        expect(response).to have_http_status(:created)
        expect(response.parsed_body["quantity"]).to eq(2)
        expect(BigDecimal(response.parsed_body["total_amount"])).to eq(product.price * 2)
      end
    end

    context "when authenticated with invalid params" do
      before { sign_in user }

      let(:order_params) { { quantity: 0, product_id: product.id } }

      it "does not create a new order" do
        expect {
          post "/api/v1/orders", params: { order: order_params }
        }.not_to change(Order, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body["errors"]).to include("Quantity must be greater than 0")
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

      before { sign_in user }

      let(:order_params) { { quantity: 2, product_id: 0 } }

      it "returns not found status" do
        post "/api/v1/orders", params: { order: order_params }
        expect(response).to have_http_status(:not_found)
        expect(response.parsed_body["error"]).to eq("Product not found")
      end
    end
  end
end
