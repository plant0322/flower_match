class Shop::MembersController < ApplicationController
  before_action :authenticate_shop!
  before_action :is_matching_login_shop, only: [:show]

  def show
    shop = current_shop
    shop_items = Item.where(shop_id: shop.id)
    @member = Member.find(params[:id])
    pre_orders = PreOrder.where(item_id: shop_items.pluck(:id), member_id: @member)
    @before_visit_pre_orders = pre_orders.where(status: 'before_visit')
    @visit_or_cancel_pre_orders = pre_orders.where(status: 'visit') + pre_orders.where(status: 'cancel')
    @reviews = Review.where(pre_order_id: pre_orders)
  end

  private

# current_shopの商品を一度も予約したことのないmemberのshow(予約履歴)は開けないようにする
  def is_matching_login_shop
    member = Member.find(params[:id])
    item = Item.find_by(shop_id: current_shop.id)
    pre_orders = PreOrder.where(item_id: item.id, member_id: member.id)
    unless pre_orders.exists?
      redirect_to shop_top_path
    end
  end
end
