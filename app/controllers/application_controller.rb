class ApplicationController < ActionController::Base

  private

  def set_tag
    @pick_up_tags = PickUpTag.active_tag.order(in_order: 'ASC')
    @tag_rank = Tag.tag_rank_item
  end
end
