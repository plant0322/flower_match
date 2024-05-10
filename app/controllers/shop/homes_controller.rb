class Shop::HomesController < ApplicationController
  before_action :authenticate_shop!

  def top
    @shop = current_shop
    @shop_items = Item.where(shop_id: @shop.id)
    @pre_orders = PreOrder.where(item_id: @shop_items.pluck(:id)).order(id: "DESC").limit(3)
  end
end
