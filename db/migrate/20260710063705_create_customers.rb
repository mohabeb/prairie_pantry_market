class CreateCustomers < ActiveRecord::Migration[7.2]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.references :province, null: false, foreign_key: true
      t.string :street
      t.string :city
      t.string :postal_code

      t.timestamps
    end
  end
end
