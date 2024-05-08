class Shop::PreOrdersController < ApplicationController
  before_action :authenticate_shop!
  def index
    @shop = current_shop
    @shop_items = Item.where(shop_id: @shop.id)
    @pre_orders = PreOrder.where(item_id: @shop_items.pluck(:id))
  end

  def show
    @pre_order = PreOrder.find(params[:id])
  end

  def user_pre_orders
  end
end
