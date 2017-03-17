require 'rails_helper'

RSpec.describe LineItem, type: :model do

  #relationships
  it {should belong_to(:cart)}
  it {should belong_to(:product)}
  # price
  it {should validate_presence_of(:price)}
  it {should_not allow_value(-1).for(:price)}
  # quantity
  it {should validate_presence_of(:quantity)}
  it {should validate_inclusion_of(:quantity).in_range(1..100)}
end
