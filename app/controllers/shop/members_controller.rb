class Shop::MembersController < ApplicationController
  before_action :authenticate_shop!
  before_action :is_matching_login_shop, only: [:show]

  def show
    shop = current_shop
    shop_items = Item.where(shop_id: shop.id)
    @member = Member.find(params[:id])
    pre_orders = PreOrder.where(item_id: shop_items, member_id: @member)
    @before_visit_pre_orders = pre_orders.where(status: 'before_visit')
                                         .order(visit_day: "ASC")
    @visit_or_cancel_pre_orders = pre_orders.where(status: ['visit', 'cancel'])
                                            .order(visit_day: "DESC").page(params[:page])
    @room = Room.where(shop_id: current_shop, member_id: @member)
    @reviews = Review.where(pre_order_id: pre_orders)
    @pick_up_tags = PickUpTag.where(is_active: true)
                             .order(id: 'DESC')
    @tag_rank = Tag.tag_rank_item
    @search = OpenStruct.new(model: 'item')
  end

  private

# current_shopの商品を一度も予約したことのないmemberのshow(予約履歴)は開けないようにする
  def is_matching_login_shop
    member = Member.find(params[:id])
    items = Item.where(shop_id: current_shop)
    pre_orders = PreOrder.where(item_id: items.pluck(:id))
                         .where(member_id: member)
    unless pre_orders.exists?
      flash[:alert] = "このユーザーからの予約はまだありません"
      redirect_to shop_top_path
    end
  end
end
