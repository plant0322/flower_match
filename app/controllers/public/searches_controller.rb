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
      @tags = Tag.all
    end
  end
end
