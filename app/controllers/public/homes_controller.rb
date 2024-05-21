class Public::HomesController < ApplicationController
  def top
    @active_items = Item.where(is_active: true)
    @items = @active_items.order(id: "DESC").page(params[:page])
    @tag_rank = Tag.tag_rank_item
  end

  def about
  end
end
