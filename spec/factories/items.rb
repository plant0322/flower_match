FactoryBot.define do
  factory :item do
    name { Faker::Lorem.characters(number: 20) }
    introduction { Faker::Lorem.characters(number: 100) }
    price { Faker::Number.between(from: 300, to: 10000) }
    size { Faker::Lorem.characters(number: 20) }
    stock { Faker::Number.between(from: 0, to: 30) }
    deadline { Faker::Number.between(from: 0, to: 7) }
    shop
    after(:build) do |item|
      item.item_image.attach(io: File.open('spec/images/item_image.jpg'), filename: 'item_image.jpg', content_type: 'image/jpeg')
    end
  end
end