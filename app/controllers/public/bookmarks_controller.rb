class Public::BookmarksController < ApplicationController

  def create
    item = Item.find(params[:item_id])
    bookmark = current_member.bookmarks.new(item_id: item.id)
    bookmark.save
    redirect_to request.referer
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
                 .where(is_active: true).order(id: 'DESC').page(params[:page])
    @tags = Tag.joins(:item_tags).group(:id).order('COUNT(item_tags.tag_id) DESC').limit(10)
  end
end
