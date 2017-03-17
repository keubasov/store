class Product < ApplicationRecord

  belongs_to :look
  has_many :line_items

  validates_presence_of :price, :quantity

  validates :quantity, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :price, numericality: {greater_than_or_equal_to: 0}

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



end
