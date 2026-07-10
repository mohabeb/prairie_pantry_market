class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :province
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :status, presence: true
  validates :subtotal_cents, :gst_cents, :pst_cents, :hst_cents, :total_cents,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end