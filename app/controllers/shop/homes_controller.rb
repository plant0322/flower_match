class Shop::HomesController < ApplicationController
  before_action :authenticate_shop!
  before_action :set_tag

  def top
    @shop = current_shop
    @shop_items = @shop.items
    @shop_items_3 = @shop_items.order(id: "DESC").limit(3)
    @pre_orders_3 = PreOrder.where(item_id: @shop_items.pluck(:id)).order(id: "DESC").limit(3)
    pre_orders = PreOrder.where(item_id: @shop_items)
    @reviews = Review.where(pre_order_id: pre_orders).order(id: "DESC").limit(3)
    @search = OpenStruct.new(model: 'item')
    # メッセージの取得
    @rooms = Room.where(shop_id: current_shop, is_take_care: false)
    @messages = []

    @rooms.each do |room|
      new_member_message = MemberMessage.where(room_id: room.id).order(created_at: "DESC").first
      new_shop_message = ShopMessage.where(room_id: room.id).order(created_at: "DESC").first

      if new_member_message && new_shop_message
        new_message = [new_member_message, new_shop_message].max_by(&:created_at)
        @messages << new_message
      elsif new_member_message
        @messages << new_member_message
      elsif new_shop_message
        @messages << new_shop_message
      end
      @messages.sort! { |a, b| b.created_at <=> a.created_at }
    end
  end
end
