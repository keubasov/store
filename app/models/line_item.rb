class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  validates :quantity, presence: true
  validates :quantity, inclusion: {in: 1..100}
end
