class Item < ApplicationRecord

  has_many :pre_orders, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :item_tags, dependent: :destroy
  has_many :tags, through: :item_tags
  belongs_to :shop
  has_one :item_check, dependent: :destroy
  has_one_attached :item_image
  has_one_attached :item_image_webp

  validates :item_image, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :size, presence: true
  validates :price, presence: true
  validates :stock, presence: true
  validates :deadline, presence: true, numericality: { in: 0..20 }

  def get_item_image(width, height)
    return unless item_image.attached?

    image = MiniMagick::Image.read(item_image.download)
    image.auto_orient
    image.resize "#{width}x#{height}^"
    image.extent "#{width}x#{height}"

    tempfile = Tempfile.new(['item_image', '.jpg'])
    image.write(tempfile.path)
    tempfile.rewind

    new_blob = ActiveStorage::Blob.create_and_upload!(
      io: tempfile,
      filename: "item_image_#{width}x#{height}.jpg",
      content_type: 'image/jpeg'
    )

    tempfile.close
    tempfile.unlink

    new_blob
  end

  def get_item_image_webp(width, height)
    return unless item_image_webp.attached?

    image = MiniMagick::Image.read(item_image_webp.download)
    image.auto_orient
    image.format('webp')
    image.resize "#{width}x#{height}^"
    image.extent "#{width}x#{height}"

    tempfile = Tempfile.new(['item_image', '.webp'])
    image.write(tempfile.path)
    tempfile.rewind

    new_blob = ActiveStorage::Blob.create_and_upload!(
      io: tempfile,
      filename: "item_image_#{width}x#{height}.webp",
      content_type: 'image/webp'
    )

    tempfile.close
    tempfile.unlink

    new_blob
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
