class Public::PickUpTagsController < ApplicationController
  before_action :set_tag

  def show
    @pick_up_tag = PickUpTag.find(params[:id])
    @items = @pick_up_tag.tag.items.active.active_shop.order(id: 'DESC').page(params[:page])
    @search = OpenStruct.new(model: 'item')
  end
end
