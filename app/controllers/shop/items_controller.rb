class Shop::ItemsController < ApplicationController
  before_action :authenticate_shop!
  before_action :set_item, only: [:edit, :update, :destroy]
  before_action :is_matching_login_shop, only: [:edit, :update]

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.shop_id = current_shop.id
    tag_list = params[:item][:tag_name].split(',')
    if @item.save
      @item.save_tags(tag_list)
      flash[:notice] = "商品を登録しました"
      redirect_to item_path(@item)
    else
      flash.now[:alert] = "商品登録に失敗しました"
      render :new
    end
  end

  def index
    @shop = Shop.find(current_shop.id)
    @items = @shop.items
  end

  def edit
  end

  def update
    tag_list = params[:item][:tag_name].split(' ')
    if @item.update(item_params)
      @item.save_tags(tag_list)
      flash[:notice] = "商品情報を更新しました"
      redirect_to request.referer
    else
      flash[:alert] = @item.errors.full_messages
      redirect_to request.referer
    end
  end

  private

  def is_matching_login_shop
    item = Item.find(params[:id])
    unless item.shop_id == current_shop.id
      redirect_to shop_top_path
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:item_image, :name, :introduction, :size, :price, :stock, :deadline, :is_active)
  end
end
