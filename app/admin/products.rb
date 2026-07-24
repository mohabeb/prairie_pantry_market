ActiveAdmin.register Product do
  permit_params :name,
                :description,
                :price_cents,
                :stock_quantity,
                :active,
                :on_sale,
                :new_arrival,
                :image,
                category_ids: []

  index do
    selectable_column
    id_column
    column :name
    column :price_cents
    column :stock_quantity
    column :active
    column :on_sale
    column :new_arrival
    column "Categories" do |product|
      product.categories.map(&:name).join(", ")
    end
    column "Image" do |product|
      product.image.attached? ? "Attached" : "No image"
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :description
      row :price_cents
      row :stock_quantity
      row :active
      row :on_sale
      row :new_arrival
      row "Categories" do |product|
        product.categories.map(&:name).join(", ")
      end
      row "Image" do |product|
        if product.image.attached?
          image_tag product.image, width: 250
        else
          "No image uploaded"
        end
      end
    end
  end

  form do |f|
    f.inputs "Product Details" do
      f.input :name
      f.input :description
      f.input :price_cents, hint: "Enter cents. Example: 799 means $7.99"
      f.input :stock_quantity
      f.input :active
      f.input :on_sale
      f.input :new_arrival
      f.input :categories, as: :check_boxes
      f.input :image, as: :file
    end

    f.actions
  end
end
