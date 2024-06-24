class Public::BookmarksController < ApplicationController

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
    @pick_up_tags = PickUpTag.active_tag.order(in_order: 'ASC')
    @tag_rank = Tag.tag_rank_item
    @search = OpenStruct.new(model: 'item')
  end
end
