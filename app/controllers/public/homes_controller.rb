class Public::HomesController < ApplicationController
  before_action :set_search
  before_action :set_tag

  def top
    items_all = Item.active.active_shop
                    .left_joins(:item_details)
                    .group('items.id')
                    .select('items.*,
                             MAX(COALESCE(item_details.updated_at, items.updated_at)) AS greatest_updated_at')
                    .order('greatest_updated_at DESC')
    @items = items_all.page(params[:page])
    @search = OpenStruct.new(model: 'item')
  end

  def about
  end

  def guide
  end

  def privacypolicy
  end

  def terms
  end

  private

  def set_search
    @search = OpenStruct.new(model: 'item')
  end

end
