FactoryBot.define do
  factory :member do
    transient do
      person { Gimei.name }
    end
    email { Faker::Internet.email }
    last_name { person.last.kanji }
    first_name { person.first.kanji }
    last_name_kana { person.last.katakana }
    first_name_kana { person.first.katakana }
    nickname { Faker::Lorem.characters(number: 5) }
    postal_code { Faker::Number.leading_zero_number(digits: 7) }
    address { Gimei.address.kanji }
    telephone_number { Faker::Number.leading_zero_number(digits: 11) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end