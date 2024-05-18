class Shop::ReviewController < ApplicationController
  def index
    @tags = Tag.joins(:item_tags).group(:id).order('COUNT(item_tags.tag_id) DESC').limit(10)
    @shop = Shop.find(params[:id])
    items = @shop.items
    pre_orders = PreOrder.where(item_id: items)
    @reviews = Review.where(pre_order_id: pre_orders)
  end
end
