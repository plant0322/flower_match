class Tag < ApplicationRecord

  has_many :item_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :items, through: :item_tags

  validates :name, presence: true, length: { maximum: 12 }


  # タグの検索
  def self.search_items(content)
    scope :merge_items, -> (tags){}
    tags = Tag.where('name LIKE?', '%'+content+'%')
    return tags.inject(init = []) {|result,tag| result + tag.items}
  end

  # 左ナビに表示する上位10件のタグを呼び出す
  def self.tag_rank_item
    joins(:item_tags)
      .group(:id)
      .order('COUNT(item_tags.tag_id) DESC')
      .limit(10)
  end
end
