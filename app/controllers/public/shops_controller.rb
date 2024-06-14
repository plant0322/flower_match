class Public::ShopsController < ApplicationController
  before_action :check_shop_is_active

  def show
    @member = current_member
    @items = @shop.items.where(is_active: true)
                        .order(updated_at: "DESC").page(params[:page])
    shop_pre_order_ids = PreOrder.where(item_id: @items.pluck(:id)).pluck(:id)
    @reviews = Review.where(pre_order_id: shop_pre_order_ids)
                     .where(is_active: 'true')
    @pick_up_tags = PickUpTag.where(is_active: true)
                             .order(in_order: 'ASC')
    @tag_rank = Tag.tag_rank_item
    @search = OpenStruct.new(model: 'item')
  end

  private

  def check_shop_is_active
    @shop = Shop.find(params[:id])
    return if admin_signed_in?
    unless @shop.is_active
      redirect_to root_path
    end
  end
end
