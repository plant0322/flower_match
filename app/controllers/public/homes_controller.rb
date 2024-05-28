class Public::HomesController < ApplicationController
  def top
    active_shops = Shop.where(is_active: true)
    active_items = Item.where(is_active: true)
    items_all = Item.where(id: active_items, shop_id: active_shops)
    @items = items_all.order(updated_at: "DESC").page(params[:page])

    @pick_up_tags = PickUpTag.where(is_active: true).order(id: 'DESC')
    @tag_rank = Tag.tag_rank_item
    @search = OpenStruct.new(model: 'item')
  end

  def about
    @search = OpenStruct.new(model: 'item')
  end
end
