class Admin::ShopsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_shop, only: [:show, :edit, :update]

  def show
    @items = Item.where(shop_id: @shop)
  end

  def edit
  end

  def update
    if @shop.update(shop_params)
      flash[:notice] = "ショップステータスを変更しました"
      redirect_to request.referer
    else
      render :edit
    end
  end

  def index
    unless params[:content].blank?
      @content = params[:content]
      @shops = Shop.where('name LIKE? OR name_kana LIKE?','%'+@content+'%','%'+@content+'%').order(id: 'DESC').page(params[:page])
    else
      @shops = Shop.all.order(id: 'DESC').page(params[:page])
    end
  end

  private

  def set_shop
    @shop = Shop.find(params[:id])
  end

  def shop_params
    params.require(:shop).permit(:is_active)
  end

end
