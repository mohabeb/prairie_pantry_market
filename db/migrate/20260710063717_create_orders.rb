class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :province, null: false, foreign_key: true
      t.string :status
      t.integer :subtotal_cents
      t.integer :gst_cents
      t.integer :pst_cents
      t.integer :hst_cents
      t.integer :total_cents

      t.timestamps
    end
  end
end
