class Public::ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
    @shop = @item.shop
  end
end
