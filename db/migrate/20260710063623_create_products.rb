class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :price_cents
      t.integer :stock_quantity
      t.boolean :active
      t.boolean :on_sale
      t.boolean :new_arrival

      t.timestamps
    end
  end
end
