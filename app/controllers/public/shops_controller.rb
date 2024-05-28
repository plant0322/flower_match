class Public::ShopsController < ApplicationController
  before_action :check_shop_is_active

  def show
    active_shops = Shop.where(is_active: true)
    @member = current_member
    #@shop = Shop.find(params[:id])
    @items = @shop.items.where(is_active: true, shop_id: active_shops).order(id: "DESC").page(params[:page])
    #shop_pre_orders = PreOrder.where(item_id: @items)
    shop_pre_order_ids = PreOrder.where(item_id: @items.pluck(:id)).pluck(:id)
    @reviews = Review.where(pre_order_id: shop_pre_order_ids)
                     .where(is_active: 'true')
    @pick_up_tags = PickUpTag.where(is_active: true).order(id: 'DESC')
    @tag_rank = Tag.tag_rank_item
    @search = OpenStruct.new(model: 'item')
  end

  private

  def check_shop_is_active
    @shop = Shop.find(params[:id])
    unless @shop.is_active
      redirect_to root_path
    end
  end
end
