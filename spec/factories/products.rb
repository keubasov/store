FactoryGirl.define do
  factory :product do
    quantity 1
    price 9.99
    trait :poplin do
      look :look, :bedclothe, :poplin
    end

    trait :sateen do
      look  :look, :bedclothe, :sateen
    end

    trait :unbleached_calico do
      look  :look, :bedclothe, :unbleached_calico
    end

    trait :blanket do
      look  :look, :blanket
    end

    trait :pillow do
      look  :look, :pillow
    end

    trait :one_half do
      b_size :one_half
    end

    trait :two do
      b_size :two
    end

    trait :euro do
      b_size :euro
    end

    trait :family do
      b_size :family
    end
  end
end
