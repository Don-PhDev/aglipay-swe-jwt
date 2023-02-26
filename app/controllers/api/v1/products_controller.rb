class Api::V1::ProductsController < ApiController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  before_action :find_product, only: [:show, :update, :destroy]

  def index
    render json: Product.all
  end

  def show
    render json: @product, status: :ok
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product, status: :ok
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    head :no_content
  end

  private

  def find_product
    @product ||= Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :category_id)
  end

  def record_not_found
    render json: { error: "Record not found" }, status: :not_found
  end
end
