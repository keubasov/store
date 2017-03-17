require 'rails_helper'

RSpec.describe Product, type: :model do

  #relationships
  it {should belong_to(:look)}
  it {should have_many(:line_items)}
  # price
  it 'when without price' do
    expect{FactoryGirl.create(:product, price: nil)}.to raise_error(ActiveRecord::RecordInvalid, / не может быть пустым/)
  end
  # it {should validate_presence_of(:price)}
  # it {should_not allow_value(-1).for(:price)}
  # # quantity
  # it {should validate_presence_of(:quantity)}
  # it {should_not allow_value(-1).for(:quantity)}

  it 'when material is bedclothe' do

  end
end
