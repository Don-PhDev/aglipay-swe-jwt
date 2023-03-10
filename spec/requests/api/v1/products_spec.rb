RSpec.describe Api::V1::ProductsController, type: :request do
  let!(:product) { create(:product) }
  let!(:category) { create(:category) }

  describe "GET /api/v1/products" do
    before { get "/api/v1/products" }

    it "returns products" do
      expect(response).to have_http_status(200)
      expect(response.body).not_to be_empty
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end

  describe "GET /api/v1/products/:id" do
    context "when the record exists" do
      before { get "/api/v1/products/#{product.id}" }

      it "returns the product" do
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)["id"]).to eq(product.id)
      end
    end

    context "when the record does not exist" do
      before { get "/api/v1/products/9999" }

      it "returns status code 404 and a not found message" do
        expect(response).to have_http_status(404)
        expect(response.body).to match(/"error":"Record not found"/)
      end
    end
  end

  describe "POST /api/v1/products" do
    context "with valid parameters" do
      let(:valid_attributes) {
        { product:
          {
            name: "New Product",
            price: 10.99,
            category_id: category.id
          }
        }
      }

      it "creates a new product" do
        expect {
          post "/api/v1/products", params: valid_attributes
        }.to change(Product, :count).by(1)

        expect(response).to have_http_status(201)
        expect(JSON.parse(response.body)["name"]).to eq("New Product")
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) {
        { product:
          {
            name: nil,
            price: nil,
            category_id: nil
          }
        }
      }

      it "does not create a new product" do
        expect {
          post "/api/v1/products", params: invalid_attributes
        }.not_to change(Product, :count)

        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)["errors"]).not_to be_empty
      end
    end
  end

  describe "PUT /api/v1/products/:id" do
    context "with valid parameters" do
      before { put "/api/v1/products/#{product.id}", params: { product: { name: "Updated Product" } } }

      it "updates the product" do
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)["name"]).to eq("Updated Product")
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) {
        { product:
          {
            name: nil,
            price: nil,
            category_id: nil
          }
        }
      }

      before { put "/api/v1/products/#{product.id}", params: invalid_attributes }

      it "does not update the product" do
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)["errors"]).not_to be_empty
      end
    end
  end

  describe "DELETE /api/v1/products/:id" do
    before { delete "/api/v1/products/#{product.id}" }

    context "when the product exists" do
      it "returns a 204 No Content status code" do
        expect(response).to have_http_status(204)
      end

      it "deletes the product" do
        expect(Product.exists?(product.id)).to be_falsey
      end
    end

    context "when the product does not exist" do
      before do
        delete api_v1_product_path
      end

      it "returns a 404 Not Found status code" do
        expect(response).to have_http_status(404)
      end

      it "returns an error message" do
        expect(response.body).to match(/"error":"Record not found"/)
      end
    end
  end
end
