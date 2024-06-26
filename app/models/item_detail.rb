class ItemDetail < ApplicationRecord
  belongs_to :item

  has_one_attached :item_detail_image

  validates :item_detail_image, presence: true
  validates :introduction, presence: true
  validates :in_order, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }

  def get_item_detail_image(width, height)
    item_detail_image.variant(resize_to_fill: [width, height]).processed
  end

  def get_item_detail_image_webp(width, height)
    item_detail_image.variant(resize_to_fill: [width, height], format: :webp).processed if item_detail_image.attached?
  end
end
