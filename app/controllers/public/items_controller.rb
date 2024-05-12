class Public::ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
    @shop = @item.shop
    @stock = @item.stock.to_i
    @stock_array = Array(1..@stock)
  end
end
