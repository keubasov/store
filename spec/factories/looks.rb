FactoryGirl.define do
  factory  :look do
    name  'look'

    trait :bedclothe do
      product_type  'bedclothe'
    end

    trait :poplin do
      description 'Bedclothe poplin'
      b_material  'poplin'
    end

    trait :unbleached_calico do
      description 'Bedclothe unbleached calico'
      b_material  'unbleached_calico'
    end

    trait :sateen do
      description 'Bedclothe sateen'
      b_material  'sateen'
    end

    trait :blanket do
      product_type 'blanket'
      description 'blanket'
    end

    trait :pillow do
      product_type 'pillow'
      description 'pillow'
    end
  end
end