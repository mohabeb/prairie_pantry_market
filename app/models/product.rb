class Product < ApplicationRecord
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  has_many :order_items, dependent: :restrict_with_error

  validates :name, presence: true
  validates :description, presence: true
  validates :price_cents, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :stock_quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :active, inclusion: { in: [true, false] }
  validates :on_sale, inclusion: { in: [true, false] }
  validates :new_arrival, inclusion: { in: [true, false] }

  scope :available, -> { where(active: true) }
  scope :on_sale, -> { where(on_sale: true) }
  scope :new_arrivals, -> { where(new_arrival: true) }

  def price
    price_cents / 100.0
  end
end