ActiveAdmin.register Page do
  permit_params :title, :slug, :content

  actions :all, except: [:destroy]

  index do
    selectable_column
    id_column
    column :title
    column :slug
    actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row :slug
      row :content
    end
  end

  form do |f|
    f.inputs "Page Content" do
      f.input :title
      f.input :slug, hint: "Use about or contact"
      f.input :content
    end

    f.actions
  end
end
