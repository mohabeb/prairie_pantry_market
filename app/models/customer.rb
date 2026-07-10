class Customer < ApplicationRecord
  belongs_to :province
  has_many :orders, dependent: :restrict_with_error

  validates :first_name, :last_name, :email, :street, :city, :postal_code, presence: true
end