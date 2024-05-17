class Tag < ApplicationRecord

  has_many :item_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :items, through: :item_tags

  validates :name, presence: true

  def self.search_items(content)
      scope :merge_items, -> (tags){}
      tags = Tag.where('name LIKE?', '%'+content+'%')
      return tags.inject(init = []) {|result,tag| result + tag.items}
  end
end
