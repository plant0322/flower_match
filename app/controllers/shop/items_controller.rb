class Shop::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update]

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
    @shop = Shop.find(current_shop.id)
    @items = @shop.items
  end

  def show
  end

  def edit
  end

  def update
    @item = Item.update(item_params)
    redirect_to shop_items_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:item_image, :name, :introduction, :size, :price, :stock, :deadline)
  end
end
