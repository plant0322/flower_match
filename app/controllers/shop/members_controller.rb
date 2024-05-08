class Shop::MembersController < ApplicationController
  before_action :authenticate_shop!

  def show
    @shop = current_shop
    @shop_items = Item.where(shop_id: @shop.id)
    @member = Member.find(params[:id])
    @pre_orders = PreOrder.where(item_id: @shop_items.pluck(:id), member_id: @member)
  end
end
