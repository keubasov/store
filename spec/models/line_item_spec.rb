require 'rails_helper'

RSpec.describe LineItem, type: :model do

  #relationships
  it {should belong_to(:cart)}
  it {should belong_to(:product)}
  # quantity
  it {should validate_presence_of(:quantity)}
  it {should validate_inclusion_of(:quantity).in_range(1..100)}

end
