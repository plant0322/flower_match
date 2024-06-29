FactoryBot.define do
  factory :item_detail do
    item
    in_order { Faker::Number.between(from: 0, to: 10) }
    introduction { Faker::Lorem.characters(number: 100) }
    after(:build) do |item_detail|
      item_detail.item_detail_image.attach(io: File.open('spec/images/item_image.jpg'), filename: 'item_image.jpg', content_type: 'image/jpeg')
    end
  end
end