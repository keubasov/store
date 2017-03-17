class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  validates :price, :quantity, presence: true
  validates :quantity, inclusion: {in: 1..100}
  validates :price, numericality: {greater_than_or_equal_to: 1}
end
