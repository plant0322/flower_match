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
    @pick_up_tags = PickUpTag.where(is_active: true)
    @tag_rank = Tag.tag_rank_item
  end

  def item_list
    active_shops = Shop.where(is_active: true)
    acive_favorite_shops = FavoriteShop.where(member_id: current_member.id, shop_id: active_shops)
    acive_favorite_shops_ids = acive_favorite_shops.pluck(:shop_id)
    @favorite_shop_items = Item.where(is_active: true, shop_id: acive_favorite_shops_ids).order(id: 'DESC').page(params[:page])
    @pick_up_tags = PickUpTag.where(is_active: true)
    @tag_rank = Tag.tag_rank_item
  end

  private

  def set_search
    @search = OpenStruct.new(model: 'item')
  end
end
