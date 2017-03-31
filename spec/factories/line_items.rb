FactoryGirl.define do
  factory :line_item do
    quantity 1
    price 100
    product
    cart
  end
end
