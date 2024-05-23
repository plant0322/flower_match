class Shop::ShopsController < ApplicationController
  before_action :authenticate_shop!
  before_action :set_current_shop
  before_action :ensure_guest_shop, only: [:edit, :unsubscribe]

  def edit
  end

  def update
    if @shop.update(shop_params)
      flash[:notice] = "ショップ情報を更新しました"
      redirect_to request.referer
    else
      flash[:alert] = "編集内容に誤りがあります"
      redirect_to request.referer
    end
  end

  def unsubscribe
  end

  def withdraw
    @shop.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  private

  def set_current_shop
    @shop = current_shop
  end

  def ensure_guest_shop
    @shop = current_shop
    if @shop.guest_shop?
      redirect_to shop_top_path, notice: 'お試しショップのため編集は出来ません。'
    end
  end

  def shop_params
    params.require(:shop).permit(:shop_image, :name, :name_kana, :introduction, :representative_name, :postal_code, :address, :opening_hour, :holiday, :parking, :note, :payment_method, :direction, :telephone_number)
  end
end
