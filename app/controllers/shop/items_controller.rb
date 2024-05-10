class Shop::ItemsController < ApplicationController
  before_action :authenticate_shop!
  before_action :set_item, only: [:show, :edit, :update]

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.shop_id = current_shop.id
    if @item.save
      flash[:notice] = "商品を登録しました"
    redirect_to shop_item_path(@item)
    else
      flash.now[:alert] = "商品登録に失敗しました"
      render :new
    end
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
    if @item.update(item_params)
      flash[:notice] = "商品情報を更新しました"
      redirect_to request.referer
    else
      flash.now[:alert] = "商品情報の更新に失敗しました"
      render :edit
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:item_image, :name, :introduction, :size, :price, :stock, :deadline, :is_active)
  end
end
