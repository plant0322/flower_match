class Admin::TagsController < ApplicationController

  def create
  end

  def update
  end

  def destroy
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to request.referer
  end

  def index
    @tags = Tag.all
    @tag_rank = Tag.joins(:item_tags).group(:id).order('COUNT(item_tags.tag_id) DESC').limit(10)
    #@tags = Tag.joins(:item_tags).group(:id).order('COUNT(item_tags.tag_id) DESC')
  end
end