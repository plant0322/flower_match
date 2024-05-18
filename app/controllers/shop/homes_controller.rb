class Shop::HomesController < ApplicationController
  before_action :authenticate_shop!

  def top
    @shop = current_shop
    @shop_items = @shop.items
    @shop_items_3 = @shop_items.order(id: "DESC").limit(3)
    @pre_orders_3 = PreOrder.where(item_id: @shop_items.pluck(:id)).order(id: "DESC").limit(3)
    pre_orders = PreOrder.where(item_id: @shop_items)
    @reviews = Review.where(pre_order_id: pre_orders).order(id: "DESC").limit(3)
  end
end
