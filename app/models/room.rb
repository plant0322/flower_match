class Room < ApplicationRecord
  has_many :message_rooms, dependent: :destroy
  has_many :member_messages, dependent: :destroy
  has_many :shop_messages, dependent: :destroy
end
