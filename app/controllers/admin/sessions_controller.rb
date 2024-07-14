# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  before_action :set_search_check_login, only: [:new]
  before_action :set_tag
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

  def after_sign_in_path_for(resource)
    admin_top_path
  end

  def after_sign_out_path_for(resource)
    admin_session_path
  end

  private

  def set_search_check_login
    @search = OpenStruct.new(model: 'item')
    if shop_signed_in? || member_signed_in?
      redirect_to root_path
    end
  end

end
