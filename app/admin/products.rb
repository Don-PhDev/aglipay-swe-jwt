ActiveAdmin.register Product do
  menu priority: 1

  permit_params :name, :price, :category_id
end
