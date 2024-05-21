
# 不要？
class Shop::ReviewsController < ApplicationController
  before_action :authenticate_admin_or_shop!

  def index
    @tags = Tag.joins(:item_tags).group(:id).order('COUNT(item_tags.tag_id) DESC').limit(10)
    @member = Member.find(params[:member_id])
    member_reviews = Review.where(member_id: @member)
    shop_item_ids = Item.where(shop_id: current_shop)
    member_pre_orders = PreOrder.where(item_id: shop_item_ids)
                                .where(member_id: @member)
    @reviews = Review.where(pre_order_id: member_pre_orders)
  end

  private

  def authenticate_admin_or_shop!
    unless shop_signed_in? || admin_signed_in?
      redirect_to root_path
    end
  end
end
