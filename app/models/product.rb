class Product < ApplicationRecord

  before_destroy :ensure_not_referensed_by_any_line_items
  belongs_to :look
  has_many :line_items

  validates_presence_of :price, :quantity
  validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  validates :quantity, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  with_options if: "look.product_type == 'bedclothe'" do |bc|
    bc.validates_presence_of :b_size
  end

#######################################
### Get arrays from enum types     ####
#######################################

  def self.b_sizes_for_select
    enum_for_select 'bedclothes_size'
  end

#######################################
###           private              ####
#######################################
  private
  def ensure_not_referensed_by_any_line_items
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Существуют товарные позиции')
      throw(:abort)
      return false
    end
  end


end
