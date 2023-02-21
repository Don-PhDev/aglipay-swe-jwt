ActiveAdmin.register Order do
  menu priority: 3

  permit_params :quantity, :total_amount, :user_id, :product_id

  controller do
    before_action :load_products, only: [:new, :create, :edit, :update]

    def load_products
      gon.products = Product.all.select(:id, :name, :price)
    end
  end
end
