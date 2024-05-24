class Public::ItemsController < ApplicationController
  def show
    session[:item_id] = params[:id]
    @item = Item.find(params[:id])
    @shop = @item.shop
    @stock = @item.stock.to_i
    @stock_array = Array(1..@stock)

    item_tags = ItemTag.where(item_id: @item.id)
    @item_tags = Tag.where(id: item_tags.pluck(:tag_id))
    @pick_up_tags = PickUpTag.where(is_active: true)
    @tag_rank = Tag.tag_rank_item
    @search = OpenStruct.new(model: 'item')
  end
end
