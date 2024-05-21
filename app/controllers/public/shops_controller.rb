class Public::ShopsController < ApplicationController
  def show
    @member = current_member
    @shop = Shop.find(params[:id])
    @items = @shop.items.order(id: "DESC").page(params[:page])
    shop_pre_orders = PreOrder.where(item_id: @items)
    @reviews = Review.where(pre_order_id: shop_pre_orders)
                     .where(is_active: 'true')
    @tag_rank = Tag.tag_rank_item
  end
end
