class Public::ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
    @shop = @item.shop
    @stock = @item.stock.to_i
    @stock_array = Array(1..@stock)
    item_tags = ItemTag.where(item_id: @item.id)
    @tags = Tag.where(id: item_tags.pluck(:tag_id))
  end
end
