class Public::ItemsController < ApplicationController
  before_action :permission_check

  def show
    session[:item_id] = params[:id]
    @shop = @item.shop
    @stock = @item.stock.to_i
    @stock_array = Array(1..@stock)
    @item_details = ItemDetail.where(item_id: @item.id).order(in_order: 'ASC')
    @item_detail_new = ItemDetail.new

    item_tags = ItemTag.where(item_id: @item.id)
    @item_tags = Tag.where(id: item_tags.pluck(:tag_id))
    @pick_up_tags = PickUpTag.where(is_active: true).order(in_order: 'ASC')
    @tag_rank = Tag.tag_rank_item
    @search = OpenStruct.new(model: 'item')
  end

  private

  def permission_check
    @item = Item.find(params[:id])
    unless @item.item_check.permission == 'permit' || admin_signed_in? || (shop_signed_in? && @item.shop_id == current_shop.id)
      redirect_to root_path
    end
  end
end
