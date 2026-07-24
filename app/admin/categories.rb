ActiveAdmin.register Category do
  permit_params :name, :description, product_ids: []

  index do
    selectable_column
    id_column
    column :name
    column :description
    column "Products Count" do |category|
      category.products.count
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :description
      row "Products" do |category|
        category.products.map(&:name).join(", ")
      end
    end
  end

  form do |f|
    f.inputs "Category Details" do
      f.input :name
      f.input :description
      f.input :products, as: :check_boxes
    end

    f.actions
  end
end
