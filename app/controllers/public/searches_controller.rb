class Public::SearchesController < ApplicationController

  def search
    @content = params[:content]
    @model = params[:model]
    if @model == 'item'
      @records = Item.where('name LIKE?', '%'+@content+'%')
    elsif @model == 'shop'
      @records = Shop.where('name LIKE?', '%'+@content+'%')
    else #@model = 'tag'
      @records = Tag.search_items(@content)
      @tags = Tag.joins(:item_tags).group(:id).order('COUNT(item_tags.tag_id) DESC').limit(10)
    end
  end
end
