class Public::SearchesController < ApplicationController

  def search
    active_shops = Shop.where(is_active: true)
    @content = params[:content]
    @model = params[:model]
    @pick_up_tags = PickUpTag.where(is_active: true)
    @tag_rank = Tag.tag_rank_item
    @tags = Tag.tag_rank_item.limit(50)
    if @model == 'item'
      @records = Item.where('name LIKE? OR introduction LIKE?','%'+@content+'%','%'+@content+'%').order(id: 'DESC')
                     .where(is_active: true, shop_id: active_shops).page(params[:page])
    elsif @model == 'shop'
      @records = Shop.where('name LIKE? OR name_kana LIKE?', '%'+@content+'%', '%'+@content+'%').order(id: 'DESC')
                     .where(is_active: true).page(params[:page])
    else #@model = 'tag'
      active_shops = Shop.where(is_active: true)
      active_items = Item.where(is_active: true, shop_id: active_shops)
      @records = Tag.search_items(@content, active_items)
    end
  end
end
