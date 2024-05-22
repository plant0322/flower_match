class ShopMessage < ApplicationRecord
  belongs_to :shop
  belongs_to :room

  validates :message, presence: true
end
