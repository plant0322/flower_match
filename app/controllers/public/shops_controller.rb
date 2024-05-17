class Public::ShopsController < ApplicationController
  def show
    @member = current_member
    @shop = Shop.find(params[:id])
    @items = @shop.items
    @tags = Tag.joins(:item_tags).group(:id).order('COUNT(item_tags.tag_id) DESC').limit(10)
  end
end
