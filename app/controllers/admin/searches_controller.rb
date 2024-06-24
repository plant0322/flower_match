# 消す？

class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @pick_up_tags = PickUpTag.active_tag
    @tag_rank = Tag.tag_rank_item
      shop = Shop.where('name LIKE ? OR name_kana LIKE ?', "%#{@content}%", "%#{@content}%")
      member = Member.where('last_name LIKE? OR first_name LIKE? OR last_name_kana LIKE? OR first_name_kana LIKE?',
                             "%#{@content}%", "%#{@content}%", "%#{@content}%", "%#{@content}%")
    if params[:shop]
      @records = shop.order(id: 'DESC')
    elsif params[:members]
      @records = Member.where('last_name LIKE? OR first_name LIKE? OR last_name_kana LIKE? OR first_name_kana LIKE? OR
                               telephone_number LIKE? OR postal_code LIKE? OR address LIKE?',
                               "%#{@content}%", "%#{@content}%", "%#{@content}%", "%#{@content}%", "%#{@content}%", "%#{@content}%", "%#{@content}%").order(id: 'DESC')
    else # params[:reviews]
      member_pre_orders = PreOrder.where(member_id: member)
      shop_items = Item.where(shop_id: shop)
      shop_pre_orders = PreOrder.where(item_id: shop_items)
      member_reviews = Review.where(pre_order_id: member_pre_orders)
      shop_reviews = Review.where(pre_order_id: shop_pre_orders)
      @records = (member_reviews + shop_reviews).uniq
    end
  end
end
