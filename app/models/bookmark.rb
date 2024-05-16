class Bookmark < ApplicationRecord
  belongs_to :member
  belongs_to :item

  validates :member_id, uniqueness: {scope: :item_id}
end
