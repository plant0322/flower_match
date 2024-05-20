class Public::ShopsController < ApplicationController
  def show
    @member = current_member
    @shop = Shop.find(params[:id])
    @items = @shop.items
    shop_pre_orders = PreOrder.where(item_id: @items)
    @reviews = Review.where(pre_order_id: shop_pre_orders)
                     .where(is_active: 'true')
    @tags = Tag.joins(:item_tags).group(:id).order('COUNT(item_tags.tag_id) DESC').limit(10)
  end
end
