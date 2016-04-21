FactoryGirl.define do
  factory :review do
    title  { FFaker::Lorem.phrase }
    description { FFaker::Lorem.sentence }
    rating { rand(1..5) }
    recommend { rand(2) == 1 }
    association :customer
    association :product
  end

  factory :customer do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
  end

  factory :product do
    title { FFaker::Product.product_name }
    price { 299.0 }
  end

end
