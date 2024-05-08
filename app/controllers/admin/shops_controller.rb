class Admin::ShopsController < ApplicationController
  before_action :authenticate_admin!
  def show
    @shop = Shop.find(params[:id])
    @items = Item.where(shop_id: @shop)
  end

  def edit
    @shop = Shop.find(params[:id])
  end

  def update
    @shop = Shop.update(shop_params)
    redirect_to request.referer
  end

  def index
    @shops = Shop.all
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :name_kana, :introduction, :representative_name, :postal_code, :address, :opening_hour, :holiday, :parking, :note, :payment_method, :direction, :telephone_number, :is_active)
  end

end
