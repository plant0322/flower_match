class Public::HomesController < ApplicationController
  def top
    @active_items = Item.where(is_active: true)
    @items = @active_items.order(id: "DESC").page(params[:page])
    @tags = Tag.joins(:item_tags).group(:id).order('COUNT(item_tags.tag_id) DESC').limit(10)
  end

  def about
  end
end
