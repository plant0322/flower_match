# frozen_string_literal: true

class Shop::SessionsController < Devise::SessionsController
  before_action :shop_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def guest_sign_in
    shop = Shop.guest
    sign_in shop
    redirect_to shop_top_path, notice: "お試しショップでログインしました。"
  end

  def after_sign_in_path_for(resource)
    shop_top_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  private

  def shop_state
    shop = Shop.find_by(email: params[:shop][:email])
    return if shop.nil?
    return unless shop.valid_password?(params[:shop][:password])
    unless shop.is_active
      flash[:alert] = "すでに退会されているアカウントです。申し訳ありませんが、管理者にお問い合わせください。"
      redirect_to new_shop_registration_path
    end
  end

end
