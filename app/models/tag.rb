class Tag < ApplicationRecord

  has_many :item_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :items, through: :item_tags

  validates :name, presence: true, length: { maximum: 12 }


  # タグの検索
  def self.search_items(content, active_items)
    #scope :merge_items, -> (tags){}
    tags = Tag.where('name LIKE?', '%'+content+'%')
    tags.inject([]) do |result, tag|
      result + tag.items.where(id: active_items.ids)
    end.uniq
    #return tags.inject(init = []) {|result,tag| result + tag.items}.uniq
  end

  # 左ナビに表示する上位10件のタグを呼び出す
  def self.tag_rank_item
    active_shops = Shop.where(is_active: true)
    active_items = Item.where(is_active: true, shop_id: active_shops).select(:id)
    joins(:item_tags)
      .where(item_tags: { item_id: active_items })
      .group(:id)
      .order('COUNT(item_tags.tag_id) DESC')
      .limit(10)
  end
end
