ActiveAdmin.register Category do
  menu priority: 2

  permit_params :name

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  filter :name

  form do |f|
    f.inputs "Category Details" do
      f.input :name
    end
    f.actions
  end
end
