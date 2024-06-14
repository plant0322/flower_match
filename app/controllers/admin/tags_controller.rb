class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!

  def create
  end

  def update
  end

  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    flash[:notice] = "タグを削除しました"
    redirect_to request.referer
  end

  def index
    @tags = Tag.left_joins(:item_tags)
               .group(:id)
               .order('COUNT(item_tags.tag_id) DESC')
    @pick_up_tag = PickUpTag.new
    @pick_up_tags = PickUpTag.all.order(in_order: 'ASC')
    @tag_rank = Tag.tag_rank_item
    @search = OpenStruct.new(model: 'item')
  end
end
