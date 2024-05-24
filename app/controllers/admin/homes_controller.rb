class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @pick_up_tags = PickUpTag.where(is_active: true)
    @tag_rank = Tag.tag_rank_item
  end
end
