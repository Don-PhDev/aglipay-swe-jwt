class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_user!, only: :create

  def index
    render json: Order.all
  end

  def create
    product = Product.find(order_params[:product_id])
    order = current_user.orders.new(order_params.merge(total_amount: product.price * order_params[:quantity].to_i))
    order.user_id = current_user.id

    if order.save
      render json: order, status: :created
    else
      render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
    end

  rescue ActiveRecord::RecordNotFound
    render json: { error: "Product not found" }, status: :not_found
  end

  private

  def order_params
    params.require(:order).permit(:quantity, :product_id).tap do |whitelisted|
      whitelisted[:quantity] = params[:order][:quantity].to_i
    end
  end

  # Override the Devise default authenticate_user! method to return 401 instead of 302
  def authenticate_user!
    head :unauthorized unless user_signed_in?
  end
end
