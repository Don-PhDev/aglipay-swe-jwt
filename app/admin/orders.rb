ActiveAdmin.register Order do
  menu priority: 3

  permit_params :quantity, :total_amount, :user_id, :product_id

  controller do
    before_action :load_products, only: [:new, :create, :edit, :update]

    def load_products
      gon.products = Product.all.select(:id, :name, :price)
    end
  end

  index do
    selectable_column
    id_column
    column :user
    column :product
    column :quantity
    column :total_amount
    column :created_at
    actions
  end

  filter :user
  filter :product
  filter :created_at

  form do |f|
    f.inputs do
      f.input :user
      f.input :product
      f.input :quantity
      f.input :total_amount
    end
    f.actions
  end
end
