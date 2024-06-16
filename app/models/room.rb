class Room < ApplicationRecord
  has_many :member_messages, dependent: :destroy
  has_many :shop_messages, dependent: :destroy
  belongs_to :member
  belongs_to :shop
end
