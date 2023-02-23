ActiveAdmin.register Product do
  menu priority: 1

  permit_params :name, :price, :category_id

  form do |f|
    f.inputs "Product Details" do
      f.input :name
      f.input :price
      f.input :category
    end
    f.actions
  end
end
