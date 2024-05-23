class Public::ShopsController < ApplicationController
  def show
    @member = current_member
    @shop = Shop.find(params[:id])
    @items = @shop.items.order(id: "DESC").page(params[:page])
    #shop_pre_orders = PreOrder.where(item_id: @items)
    shop_pre_order_ids = PreOrder.where(item_id: @items.pluck(:id)).pluck(:id)
    @reviews = Review.where(pre_order_id: shop_pre_order_ids)
                     .where(is_active: 'true')
    @tag_rank = Tag.tag_rank_item
  end
end
