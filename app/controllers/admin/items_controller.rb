class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items = Item.all.order(updated_at: 'DESC').page(params[:page])
    @pick_up_tags = PickUpTag.where(is_active: true).order(id: 'DESC')
    @tag_rank = Tag.tag_rank_item
    @search = OpenStruct.new(model: 'item')
  end
end
