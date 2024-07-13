class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_tag

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
    @search = OpenStruct.new(model: 'item')
  end
end
