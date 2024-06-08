class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items = Item.all.order(updated_at: 'DESC').page(params[:page])
    @pick_up_tags = PickUpTag.where(is_active: true).order(id: 'DESC')
    @tag_rank = Tag.tag_rank_item
    @search = OpenStruct.new(model: 'item')
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    flash[:notice] = "公開状況を変更しました"
    redirect_to request.referer
  end

  def destroy
    item = Item.find(params[:id])
    if item.pre_orders.present?
      redirect_to request.referer
      flash[:alert] = "この商品には予約履歴があるため削除できません。"
      return
    else
      item.destroy
      redirect_to admin_items_path
      flash[:notice] = "商品を削除しました"
    end
  end

  private

  def item_params
    params.require(:item).permit(:is_active)
  end
end
