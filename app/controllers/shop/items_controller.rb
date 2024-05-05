class Shop::ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.shop_id = current_shop.id
    @item.save
    redirect_to shop_item_path(@item)
  end

  def index
  end

  def show
  end

  def edit
  end

  private

  def item_params
    params.require(:item).permit(:item_image, :name, :introduction, :size, :price, :stock, :deadline)
  end
end
