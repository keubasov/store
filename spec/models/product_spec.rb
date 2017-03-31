require 'rails_helper'

RSpec.describe Product, type: :model do

  #relationships
  it {should belong_to(:look)}
  it {should have_many(:line_items)}
  # price
  it 'when price is not defined' do
    expect {FactoryGirl.create(:product, price: nil)}.to raise_exception(ActiveRecord::RecordInvalid, /Цена не может быть пустым/)
  end
  it 'when price is not number' do
    expect {FactoryGirl.create(:product, price: 'price')}.to raise_exception(ActiveRecord::RecordInvalid, /Цена не является числом/)
  end
  it 'when price is less than 0' do
    expect {FactoryGirl.create(:product, price: -1)}.to(
        raise_exception(ActiveRecord::RecordInvalid, /Цена может иметь значение большее или равное 0/)
    )
  end
  it 'when price is correct' do
    expect {FactoryGirl.create(:product, price: 1)}.to change(Product, :count)
  end
  # it {should validate_presence_of(:price)}
  # it {should_not allow_value(-1).for(:price)}
  # quantity

  it 'when quantity is not defined' do
    expect {FactoryGirl.create(:product, quantity: nil)}.to raise_exception(ActiveRecord::RecordInvalid, /Количество не может быть пустым/)
  end
  it 'when quantity is not number' do
    expect {FactoryGirl.create(:product, quantity: 'quantity')}.to raise_exception(ActiveRecord::RecordInvalid, /Количество не является числом/)
  end
  it 'when quantity is less than 0' do
    expect {FactoryGirl.create(:product, quantity: -1)}.to(
        raise_exception(ActiveRecord::RecordInvalid, /Количество может иметь значение большее или равное 0/)
    )
  end
  it 'when quantity is correct' do
    expect {FactoryGirl.create(:product, quantity: 1)}.to change(Product, :count)
  end
  # it {should validate_presence_of(:quantity)}
  # it {should_not allow_value(-1).for(:quantity)}
  #
  # it 'when material is bedclothe' do
  #
  # end

  it 'try to delete product when line_item exists' do
    product=create(:product)
    product.line_items.create(attributes_for(:line_item))
    expect{product.destroy}.to_not change(Product, :count)
  end

  it 'try to delete product when line_item not exists' do
    product=create(:product)
    expect{product.delete}.to change(Product, :count)
  end

  it 'b_sizes_for_select' do
    expect(Product.b_sizes_for_select).to include ["Полутораспальное", :one_half]
  end
end
