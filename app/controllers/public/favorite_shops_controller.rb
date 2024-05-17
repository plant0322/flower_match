class Public::FavoriteShopsController < ApplicationController

  def create
    shop = Shop.find(params[:shop_id])
    favorite_shop = current_member.favorite_shops.new(shop_id: shop.id)
    favorite_shop.save
    redirect_to request.referer
  end

  def destroy
    shop = Shop.find(params[:shop_id])
    favorite_shop = current_member.favorite_shops.find_by(shop_id: shop.id)
    favorite_shop.destroy
    redirect_to request.referer
  end

  def shop_list
    favorite_shops = FavoriteShop.where(member_id: current_member.id)
    @shops = Shop.where(id: favorite_shops.pluck(:shop_id))
    @tags = Tag.joins(:item_tags).group(:id).order('COUNT(item_tags.tag_id) DESC').limit(10)
  end

  def item_list
    favorite_shops = FavoriteShop.where(member_id: current_member.id)
    shop_ids = favorite_shops.pluck(:shop_id)
    @favorite_shop_items = Item.where(shop_id: shop_ids)
    @tags = Tag.joins(:item_tags).group(:id).order('COUNT(item_tags.tag_id) DESC').limit(10)
  end
end
