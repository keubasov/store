FactoryGirl.define do

  factory :product_image do

    trait :amaretto do
      image {File.new "#{Rails.root}/spec/factories/Amaretto.jpg"}
    end

    trait :norway do
      image {File.new "#{Rails.root}/spec/factories/Norway_story.jpg"}
    end

  end
end