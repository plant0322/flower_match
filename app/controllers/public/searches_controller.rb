class Public::SearchesController < ApplicationController

  def search
    @content = params[:content]
    @model = params[:model].presence || 'item'
    @prefecture = params[:prefecture]
    @search = if @model.in?(['shop', 'tag'])
                { model: @model }
              else
                { model: 'item' }
              end
    if @prefecture.presence
      active_shops = Shop.active_shop.where(prefecture_code: @prefecture)
    else
      active_shops = Shop.active_shop
    end

    if @search[:model] == 'item'
      @records = Item.active.where('name LIKE? OR introduction LIKE?','%'+@content+'%','%'+@content+'%')
                            .order(updated_at: 'DESC')
                            .where(shop_id: active_shops).page(params[:page])
    elsif @search[:model] == 'shop'
      @records = Shop.where('name LIKE? OR name_kana LIKE? OR address LIKE?', '%'+@content+'%', '%'+@content+'%','%'+@content+'%')
                     .order(updated_at: 'DESC')
                     .where(id: active_shops).page(params[:page])
    else #@model = 'tag'
      active_items = Item.active.left_joins(:item_details)
                                .where(shop_id: active_shops)

      tag_items = Tag.search_items(@content, active_items)
      @records = Kaminari.paginate_array(tag_items).page(params[:page])
    end

    @pick_up_tags = PickUpTag.active_tag.order(in_order: 'ASC')
    @tag_rank = Tag.tag_rank_item
    @tags = Tag.tag_rank_item.limit(50)
  end
end
