class Public::HomesController < ApplicationController
  before_action :set_search

  def top
    active_shops = Shop.where(is_active: true)
    active_items = Item.where(is_active: true)
    items_all = Item.left_joins(:item_details)
                    .where(id: active_items, shop_id: active_shops)
                    .group('items.id')
                    .select('items.*,
                             MAX(COALESCE(item_details.updated_at, items.updated_at)) AS greatest_updated_at')
                    .order('greatest_updated_at DESC')
    @items = items_all.page(params[:page])

    @pick_up_tags = PickUpTag.where(is_active: true).order(id: 'DESC')
    @tag_rank = Tag.tag_rank_item
    @search = OpenStruct.new(model: 'item')
  end

  def about
  end

  def guide
  end

  def privacypolicy
  end

  private

  def set_search
    @search = OpenStruct.new(model: 'item')
  end

end
