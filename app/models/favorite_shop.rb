class FavoriteShop < ApplicationRecord
  belongs_to :shop
  belongs_to :member

  validates :member_id, uniqueness: {scope: :shop_id}
end
