require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :request do
  let!(:product) { create(:product) }
  let!(:category) { create(:category) }
  let(:valid_attributes) {
    { product:
      {
        name: "New Product",
        price: 10.99,
        category_id: category.id
      }
    }
  }
  let(:invalid_attributes) {
    { product:
      {
        name: nil,
        price: nil,
        category_id: nil
      }
    }
  }

  describe "GET /api/v1/products" do
    before { get '/api/v1/products' }

    it "returns products" do
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /api/v1/products/:id" do
    before { get "/api/v1/products/#{product.id}" }

    context "when the record exists" do
      it "returns the product" do
        expect(json).not_to be_empty
        expect(json['id']).to eq(product.id)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the record does not exist" do
      before { get "/api/v1/products/9999" }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/"error":"Record not found"/)
      end
    end
  end

  describe "POST /api/v1/products" do
    context "with valid parameters" do
      before { post '/api/v1/products', params: valid_attributes }

      it "creates a new product" do
        expect(json['name']).to eq('New Product')
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "with invalid parameters" do
      before { post '/api/v1/products', params: invalid_attributes }

      it "does not create a new product" do
        expect(json['errors']).not_to be_empty
      end

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PUT /api/v1/products/:id" do
    context "with valid parameters" do
      before { put "/api/v1/products/#{product.id}", params: { product: { name: "Updated Product" } } }

      it "updates the product" do
        expect(json['name']).to eq('Updated Product')
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "with invalid parameters" do
      before { put "/api/v1/products/#{product.id}", params: invalid_attributes }

      it "does not update the product" do
        expect(json['errors']).not_to be_empty
      end

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "DELETE /api/v1/products/:id" do
    before { delete "/api/v1/products/#{product.id}" }

    context 'when the product exists' do
      it 'returns a 204 No Content status code' do
        expect(response).to have_http_status(204)
      end

      it 'deletes the product' do
        expect(Product.exists?(product.id)).to be_falsey
      end
    end

    context 'when the product does not exist' do
      before do
        delete api_v1_product_path
      end

      it 'returns a 404 Not Found status code' do
        expect(response).to have_http_status(404)
      end

      it 'returns an error message' do
        expect(response.body).to match(/"error":"Record not found"/)
      end
    end
  end
end
