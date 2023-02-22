class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    product = Product.find(params[:product_id])
    order = current_user.orders.build(quantity: params[:quantity])

    order.product = product

    if order.save
      render json: order, status: :created
    else
      render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
