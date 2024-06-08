class Admin::ItemChecksController < ApplicationController
  before_action :authenticate_admin!

  def update
    item = Item.find(params[:item_id])
    item_check = ItemCheck.find_by(item_id: item.id)
    item_check.update(item_check_params)
    unless item_check.permission == 'permit'
      item.update(is_active: false)
    end
    flash[:notice] = "「" + item_check.permission_i18n + "」に更新しました。"
    redirect_to request.referer
  end

  private

  def item_check_params
    params.require(:item_check).permit(:permission)
  end
end
