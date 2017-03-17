FactoryGirl.define do

  factory :product_image do
    trait :amaretto do
      image_file_name "#{Rails.root}/spec/factories/images/Amaretto.jpg"
    end

    trait :norway do
      image_file_name "#{Rails.root}/spec/factories/images/Norway_story.jpg"
    end

  end
end