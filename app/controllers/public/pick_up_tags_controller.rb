class Public::PickUpTagsController < ApplicationController

  def show
    @pick_up_tag = PickUpTag.find(params[:id])
    @items = @pick_up_tag.tag.items.active.active_shop.order(id: 'DESC').page(params[:page])
    @pick_up_tags = PickUpTag.active_tag.order(in_order: 'ASC')
    @tag_rank = Tag.tag_rank_item
    @search = OpenStruct.new(model: 'item')
  end
end
