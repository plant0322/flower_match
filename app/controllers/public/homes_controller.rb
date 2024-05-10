class Public::HomesController < ApplicationController
  def top
    @items = Item.all.order(id: "DESC")
  end

  def about
  end
end
