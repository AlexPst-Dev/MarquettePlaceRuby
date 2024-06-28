class Product < ApplicationRecord
  belongs_to :seller
  has_many :orders

  validates :stock, numericality: { greater_than_or_equal_to: 0 }
end
