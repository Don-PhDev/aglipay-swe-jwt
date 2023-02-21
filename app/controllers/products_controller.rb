class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :update]

  def index
    render json: Product.all
  end

  def show
    render json: @product
  end

  def create
    product = Product.create(product_params)
    render json: product
  end

  def update
    @product.update(product_params)
    render json: @product
  end

  def destroy
    Product.destroy(params[:id])
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :category_id)
  end
end
