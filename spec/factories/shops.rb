FactoryBot.define do
  factory :shop do
    transient do
      person { Gimei.name }
    end
    email { Faker::Internet.email }
    name { Faker::Lorem.characters(number: 5) }
    representative_name { person.kanji }
    name_kana { person.first.katakana }
    introduction { Faker::Lorem.characters(number: 100) }
    postal_code { Faker::Number.leading_zero_number(digits: 7) }
    address { Gimei.address.kanji }
    direction { Faker::Lorem.characters(number: 15) }
    telephone_number { Faker::Number.leading_zero_number(digits: 11) }
    parking { Faker::Lorem.characters(number: 10) }
    opening_hour { Faker::Lorem.characters(number: 10) }
    holiday { Faker::Lorem.characters(number: 10) }
    payment_method { Faker::Lorem.characters(number: 20) }
    note { Faker::Lorem.characters(number: 30) }
    prefecture_code { Faker::Number.between(from: 2, to: 48) }
    password { 'password' }
    password_confirmation { 'password' }

    after(:build) do |shop|
      shop.shop_image.attach(io: File.open('spec/images/shop_image.jpg'), filename: 'shop_image.jpg', content_type: 'image/jpeg')
    end
  end
end