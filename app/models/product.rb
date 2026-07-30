class Product < ApplicationRecord
  has_one_attached :image

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

  def to_s
  name

def self.ransackable_attributes(auth_object = nil)
  [
    "active",
    "created_at",
    "description",
    "id",
    "id_value",
    "name",
    "new_arrival",
    "on_sale",
    "price_cents",
    "stock_quantity",
    "updated_at"
  ]
end
end
def self.ransackable_associations(auth_object = nil)
  [
    "categories",
    "image_attachment",
    "image_blob",
    "order_items",
    "product_categories"
  ]
end
end
