class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_search_and_tag

  def top
    @items = Item.left_joins(:item_details)
                 .group('items.id')
                 .select('items.*,
                           MAX(COALESCE(item_details.updated_at, items.updated_at)) AS greatest_updated_at')
                 .order('greatest_updated_at DESC').limit(3)
    @reviews = Review.all.order(id: 'DESC').limit(3)
  end

  def guide
  end

  private

  def set_search_and_tag
    @pick_up_tags = PickUpTag.where(is_active: true).order(in_order: 'ASC')
    @tag_rank = Tag.tag_rank_item
    @search = OpenStruct.new(model: 'item')
  end
end
