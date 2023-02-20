ActiveAdmin.register Order do
  menu priority: 3

  permit_params :quantity, :total_amount, :user_id, :product_id
end
