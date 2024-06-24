class Public::FavoriteShopsController < ApplicationController
  before_action :authenticate_member!
  before_action :set_search, only: [:shop_list, :item_list]

  def create
    @shop = Shop.find(params[:shop_id])
    favorite_shop = current_member.favorite_shops.new(shop_id: @shop.id)
    favorite_shop.save
  end

  def destroy
    shop = Shop.find(params[:shop_id])
    favorite_shop = current_member.favorite_shops.find_by(shop_id: shop.id)
    favorite_shop.destroy
    redirect_to request.referer
  end

  def shop_list
    favorite_shops = FavoriteShop.where(member_id: current_member.id)
    @shops = Shop.where(id: favorite_shops.pluck(:shop_id), is_active: true).order(id: 'DESC').page(params[:page])
    @tag_rank = Tag.tag_rank_item
  end

  def item_list
    active_shops = Shop.active_shop
    acive_favorite_shops_ids = FavoriteShop.where(member_id: current_member.id, shop_id: active_shops).pluck(:shop_id)
    @favorite_shop_items = Item.active.where(shop_id: acive_favorite_shops_ids)
                                      .left_joins(:item_details)
                                      .group('items.id')
                                      .select('items.*,
                                               MAX(COALESCE(item_details.updated_at, items.updated_at)) AS greatest_updated_at')
                                      .order('greatest_updated_at DESC')
                                      .page(params[:page])
    @tag_rank = Tag.tag_rank_item
  end

  private

  def set_search
    @pick_up_tags = PickUpTag.active_tag.order(in_order: 'ASC')
    @search = OpenStruct.new(model: 'item')
  end
end
