FactoryBot.define do
  factory :pre_order do
    transient do
      person { Gimei.name }
    end
    item
    member
    name { item.name }
    amount { Faker::Number.between(from: 1, to: 5) }
    total_payment { amount * item.price }
    visit_day { Faker::Date.between(from: Date.today, to: 5.days.from_now) }
    visit_time { Faker::Time.between(from: Date.today, to: 5.days.from_now, format: :short) }
    purpose { Faker::Lorem.characters(number: 30) }
    note { Faker::Lorem.characters(number: 30) }
    last_name { member.last_name }
    first_name { member.first_name }
    last_name_kana { member.last_name_kana }
    first_name_kana { member.first_name_kana }
    postal_code { member.postal_code }
    address { member.address }
    telephone_number { Faker::Number.leading_zero_number(digits: 11) }
  end
end