class Item < ApplicationRecord

  has_many :pre_orders, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :item_tags, dependent: :destroy
  has_many :tags, through: :item_tags
  belongs_to :shop
  has_one_attached :item_image

  validates :item_image, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :size, presence: true
  validates :price, presence: true
  validates :stock, presence: true
  validates :deadline, presence: true, numericality: { in: 0..20 }

  def get_item_image(width, height)
    unless item_image.attached?
      file_path = Rails.root.join('app/assets/images/sample.jpg')
      item_image.attach(io: File.open(file_path), filename: 'sample.jpg', content_type: 'image/jpeg')
    end
    item_image.variant(resize_to_fill: [width, height]).processed
  end

  def bookmark_by?(member)
    bookmarks.exists?(member_id: member.id)
  end

  def self.search_for(content, method)
    if method == 'partial'
      Item.where('name LIKE?', '%'+content+'%')
    elsif method == 'perfect'
      Item.where(name: content)
    elsif method == 'forward'
      Item.where('name LIKE?', content+'%')
    else
      Item.where('name LIKE?', '%'+content)
    end
  end

  def save_tags(saveitem_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - saveitem_tags
    new_tags = saveitem_tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    new_tags.each do |new_name|
      item_tag = Tag.find_or_create_by(name: new_name)
      self.tags << item_tag
    end
  end
end
