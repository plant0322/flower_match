class Public::SearchesController < ApplicationController

  def search
    @content = params[:content]
    @model = params[:model]
    if @model == 'item'
      @records = Item.where('name LIKE?', '%'+@content+'%')
    else
      @records = Shop.where('name LIKE?', '%'+@content+'%')
    end
  end
end
