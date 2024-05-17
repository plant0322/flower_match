class Public::ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
    @shop = @item.shop
    @stock = @item.stock.to_i
    @stock_array = Array(1..@stock)
    item_tags = ItemTag.where(item_id: @item.id)
    @item_tags = Tag.where(id: item_tags.pluck(:tag_id))
    @tags = Tag.joins(:item_tags).group(:id).order('COUNT(item_tags.tag_id) DESC').limit(10)
  end
end
