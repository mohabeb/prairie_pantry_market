ActiveAdmin.register Customer do
  permit_params :first_name,
                :last_name,
                :email,
                :province_id,
                :street,
                :city,
                :postal_code

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :province
    column :city
    column :postal_code
    actions
  end

  show do
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :email
      row :province
      row :street
      row :city
      row :postal_code
    end
  end
end