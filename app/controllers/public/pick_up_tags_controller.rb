class Public::PickUpTagsController < ApplicationController

  def show
    @pick_up_tag = PickUpTag.find(params[:id])
    active_shop = Shop.where(is_active: true)
    @items = @pick_up_tag.tag.items.where(is_active: true, shop_id: active_shop).order(id: 'DESC').page(params[:page])
    @pick_up_tags = PickUpTag.where(is_active: true)
    @tag_rank = Tag.tag_rank_item
  end
end
