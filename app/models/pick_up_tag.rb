class PickUpTag < ApplicationRecord
  belongs_to :tag
  has_one_attached :tag_image

  validates :tag_image, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :in_order, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 20 }

  scope :active_tag, -> { where(is_active: true).order(in_order: 'ASC') }

  def get_tag_image(width, height)
    unless tag_image.attached?
      file_path = Rails.root.join('app/assets/images/sample.jpg')
      tag_image.attach(io: File.open(file_path), filename: 'sample.jpg', content_type: 'image/jpeg')
    end
    tag_image.variant(resize_to_fill: [width, height]).processed
  end
end
