class Public::SearchesController < ApplicationController

  def search
    active_shops = Shop.where(is_active: true)
    @content = params[:content]
    @model = params[:model].presence || 'item'
    @search = if @model.in?(['shop', 'address', 'tag'])
                { model: @model }
              else
                { model: 'item' }
              end

    if @search[:model] == 'item'
      @records = Item.where('name LIKE? OR introduction LIKE?','%'+@content+'%','%'+@content+'%')
                     .order(updated_at: 'DESC')
                     .where(is_active: true, shop_id: active_shops).page(params[:page])
    elsif @search[:model] == 'address'
      @records = Item.joins(:shop)
                     .where('shops.address LIKE :content', content: "%#{@content}%")
                     .where(is_active: true, shop_id: active_shops)
                     .order(updated_at: 'DESC').page(params[:page])
    elsif @search[:model] == 'shop'
      @records = Shop.where('name LIKE? OR name_kana LIKE? OR address LIKE?', '%'+@content+'%', '%'+@content+'%','%'+@content+'%')
                     .order(updated_at: 'DESC')
                     .where(is_active: true).page(params[:page])
    else #@model = 'tag'
      active_items = Item.where(is_active: true, shop_id: active_shops)
      tag_items = Tag.search_items(@content, active_items)
      @records = Kaminari.paginate_array(tag_items).page(params[:page])
    end

    @pick_up_tags = PickUpTag.where(is_active: true).order(id: 'DESC')
    @tag_rank = Tag.tag_rank_item
    @tags = Tag.tag_rank_item.limit(50)
  end
end
