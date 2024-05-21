class Public::SearchesController < ApplicationController

  def search
    @content = params[:content]
    @model = params[:model]
    @tag_rank = Tag.tag_rank_item
    @tags = Tag.tag_rank_item.limit(50)
    if @model == 'item'
      @records = Item.where('name LIKE? OR introduction LIKE?','%'+@content+'%','%'+@content+'%').order(id: 'DESC')
                     .where(is_active: true).page(params[:page])
    elsif @model == 'shop'
      @records = Shop.where('name LIKE? OR name_kana LIKE?', '%'+@content+'%', '%'+@content+'%').order(id: 'DESC').page(params[:page])
    else #@model = 'tag'
      @records = Tag.search_items(@content)
    end
  end
end
