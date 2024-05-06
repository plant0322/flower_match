class Public::ShopsController < ApplicationController
  def show
    @member = current_member
    @shop = Shop.find(params[:id])
    @items = @shop.items
  end
end
