ActiveAdmin.register Order do
  permit_params :status

  actions :index, :show, :edit, :update

  index do
    selectable_column
    id_column
    column :customer
    column :province
    column :status
    column :subtotal_cents
    column :gst_cents
    column :pst_cents
    column :hst_cents
    column :total_cents
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :customer
      row :province
      row :status
      row :subtotal_cents
      row :gst_cents
      row :pst_cents
      row :hst_cents
      row :total_cents
      row :created_at
    end

    panel "Order Items" do
      table_for order.order_items do
        column :product
        column :quantity
        column :unit_price_cents
        column :line_total_cents
      end
    end
  end

  form do |f|
    f.inputs "Order Status" do
      f.input :status, as: :select, collection: ["new", "pending", "paid", "shipped", "cancelled"]
    end

    f.actions
  end
end