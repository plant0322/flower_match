class Shop::SearchesController < ApplicationController
  before_action :authenticate_shop!

  def search
    @tag_rank = Tag.tag_rank_item
    @pick_up_tags = PickUpTag.where(is_active: true)
    @type = params[:type]
    @method = params[:method]
    @content = params[:content]
    shop_items = Item.where(shop_id: current_shop.id)

    if @type == 'order_member'
      content_records = PreOrder.where('last_name LIKE? OR first_name LIKE? OR last_name_kana LIKE? OR first_name_kana LIKE? OR
                                  telephone_number LIKE? OR postal_code LIKE? OR address LIKE?',
                                  '%'+@content+'%', '%'+@content+'%', '%'+@content+'%', '%'+@content+'%', '%'+@content+'%', '%'+@content+'%', '%'+@content+'%')
      @records = PreOrder.where(item_id: shop_items.pluck(:id)).and(content_records).order(id: "DESC").page(params[:page])
    elsif @type == 'order_item_all'
      order_records = PreOrder.where('name LIKE?','%'+@content+'%')
                              .where(item_id: shop_items.pluck(:id))
      items = Item.where('name LIKE? OR introduction LIKE?','%'+@content+'%','%'+@content+'%')
      item_records = PreOrder.where(item_id: items)
                             .where(item_id: shop_items.pluck(:id))
      @records = (order_records + item_records).uniq
    elsif @type == 'order_item'
      order_records = PreOrder.search_for(@content, @method)
                              .where(item_id: shop_items.pluck(:id))
      item_ids = Item.search_for(@content, @method)
      item_records = PreOrder.where(item_id: item_ids)
                             .where(item_id: shop_items.pluck(:id))
      @records = (order_records + item_records).uniq
    elsif @type == 'item'
      @records = Item.where('name LIKE? OR introduction LIKE?','%'+@content+'%','%'+@content+'%')
                     .where(id: shop_items.pluck(:id)).order(id: "DESC").page(params[:page])
    else # @type == 'item_name'
      @records = Item.search_for(@content, @method)
                     .where(id: shop_items.pluck(:id)).order(id: "DESC").page(params[:page])
    end
  end
end
