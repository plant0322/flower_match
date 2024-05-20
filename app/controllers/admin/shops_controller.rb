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
      flash[:notice] = "ショップ情報を更新しました"
      redirect_to request.referer
    else
      flash.now[:alert] = "ショップ情報の更新に失敗しました"
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
    params.require(:shop).permit(:name, :name_kana, :introduction, :representative_name, :postal_code, :address, :opening_hour, :holiday, :parking, :note, :payment_method, :direction, :telephone_number, :is_active)
  end

end
