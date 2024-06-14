class ItemDetail < ApplicationRecord
  belongs_to :item

  has_one_attached :item_detail_image

  validates :item_detail_image, presence: true
  validates :introduction, presence: true
  validates :in_order, presence: true, numericality: { in: 0..10 }

  def get_item_detail_image(width, height)
    item_detail_image.variant(resize_to_fill: [width, height]).processed
  end
end
