class Item < ApplicationRecord

  has_many :pre_orders, dependent: :destroy
  has_many :item_tags, dependent: :destroy
  belongs_to :shop

  validates :name, presence: true
  validates :introduction, presence: true
  validates :size, presence: true
  validates :price, presence: true
  validates :stock, presence: true
  validates :deadline, presence: true
end
