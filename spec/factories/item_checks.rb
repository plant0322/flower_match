FactoryBot.define do
  factory :item_check do
    item
    label_check { true }
    permission { 0 }
  end
end