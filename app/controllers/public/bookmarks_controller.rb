class Public::BookmarksController < ApplicationController
  before_action :set_tag

  def create
    @item = Item.find(params[:item_id])
    bookmark = current_member.bookmarks.new(item_id: @item.id)
    bookmark.save
  end

  def destroy
    item = Item.find(params[:item_id])
    bookmark = current_member.bookmarks.find_by(item_id: item.id)
    bookmark.destroy
    redirect_to request.referer
  end

  def bookmark_list
    bookmark_items = Bookmark.where(member_id: current_member.id)
    @items = Item.where(id: bookmark_items.pluck(:item_id))
                 .active.active_shop.order(id: 'DESC').page(params[:page])
    @search = OpenStruct.new(model: 'item')
  end
end
