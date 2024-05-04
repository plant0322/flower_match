class Tag < ApplicationRecord

  has_many :item_tags, dependent: :destroy

  validates :name, presence: true
end
