FactoryBot.define do
  factory :pick_up_tag do
    tag
    name { Faker::Lorem.characters(number: 10) }
    introduction { Faker::Lorem.characters(number: 100) }
    in_order { Faker::Number.between(from: 0, to: 20) }
    after(:build) do |pick_up_tag|
      pick_up_tag.tag_image.attach(io: File.open('spec/images/item_image.jpg'), filename: 'item_image.jpg', content_type: 'image/jpeg')
    end
  end
end