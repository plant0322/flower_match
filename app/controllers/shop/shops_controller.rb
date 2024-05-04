class Shop::ShopsController < ApplicationController
  before_action :set_current_shop

  def edit
  end

  def update
    @shop.update(shop_params)
    redirect_to request.referer
  end

  def unsubscribe
  end

  private

  def set_current_shop
    @shop = current_shop
  end

  def shop_params
    params.require(:shop).permit(:name, :name_kana, :introduction, :representative_name, :postal_code, :address, :opening_hour, :holiday, :parking, :note, :payment_method, :direction, :telephone_number)
  end
end
