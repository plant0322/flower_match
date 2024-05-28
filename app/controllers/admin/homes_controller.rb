class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @reviews = Review.all.order(id: 'DESC').limit(3)
    @pick_up_tags = PickUpTag.where(is_active: true).order(id: 'DESC')
    @tag_rank = Tag.tag_rank_item
    @search = OpenStruct.new(model: 'item')
  end
end
