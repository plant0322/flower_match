class Public::HomesController < ApplicationController
  def top
    @active_items = Item.where(is_active: true)
    @items = @active_items.order(id: "DESC")
  end

  def about
  end
end
