class Page < ApplicationRecord
  validates :title, :slug, :content, presence: true
  validates :slug, uniqueness: true
end