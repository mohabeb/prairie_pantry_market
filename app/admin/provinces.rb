ActiveAdmin.register Province do
  permit_params :name, :gst_rate, :pst_rate, :hst_rate

  index do
    selectable_column
    id_column
    column :name
    column :gst_rate
    column :pst_rate
    column :hst_rate
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :gst_rate
      row :pst_rate
      row :hst_rate
    end
  end
end