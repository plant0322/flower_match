class Shop::ShopsController < ApplicationController
  before_action :authenticate_shop!
  before_action :set_current_shop

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

  def unsubscribe
  end

  private

  def set_current_shop
    @shop = current_shop
  end

  def shop_params
    params.require(:shop).permit(:shop_image, :name, :name_kana, :introduction, :representative_name, :postal_code, :address, :opening_hour, :holiday, :parking, :note, :payment_method, :direction, :telephone_number)
  end
end
