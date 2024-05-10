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

  def update
    @pre_order = PreOrder.find(params[:id])
    @pre_order.update(pre_order_params)
    redirect_to shop_pre_order_path(@pre_order)
  end

  private

  def pre_order_params
    params.require(:pre_order).permit(:status, :visit_day)
  end

end
