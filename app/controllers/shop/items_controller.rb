class Shop::ItemsController < ApplicationController
  before_action :authenticate_shop!
  before_action :set_item, only: [:edit, :update, :destroy]
  before_action :is_matching_login_shop, only: [:edit, :update]
  before_action :set_tag_rank, only: [:edit, :index, :new]

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @tag_list = @item.tags.pluck(:name).join(',')
    @item.shop_id = current_shop.id
    tag_list = params[:item][:tag_name].split(',')
    if @item.save
      if params[:item][:first_is_active]
        @item.update(is_active: true)
      end
      @item.save_tags(tag_list)
      flash[:notice] = "商品を登録しました"
      redirect_to item_path(@item)
    else
      flash.now[:alert] = "入力内容に誤りがあります"
      render :new
    end
  end

  def index
    @shop = Shop.find(current_shop.id)
    @items = @shop.items.order(id: 'DESC').page(params[:page])
  end

  def edit
    @tag_list = @item.tags.pluck(:name).join(',')
  end

  def update
    tag_list = params[:item][:tag_name].split(',')
    if @item.update(item_params)
      @item.save_tags(tag_list)
      if params[:item][:first_is_active] == 'true'
        @item.update(is_active: true)
      end
      flash[:notice] = "商品情報を更新しました"
      redirect_to request.referer
    else
      flash[:alert] = "編集内容に誤りがあります"
      redirect_to request.referer
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to shop_items_path
    flash[:notice] = "商品を削除しました"
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

  def set_tag_rank
    @pick_up_tags = PickUpTag.where(is_active: true)
    @tag_rank = Tag.tag_rank_item
  end

  def item_params
    params.require(:item).permit(:item_image, :name, :introduction, :size, :price, :stock, :deadline, :is_active, :first_is_active)
  end
end
