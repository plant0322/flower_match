class Shop::SearchesController < ApplicationController
  def search
    @type = params[:type]
    @method = params[:method]
    @content = params[:content]

    if @type == 'order_member'
      @records = PreOrder.where(['last_name LIKE? OR first_name LIKE? OR last_name_kana LIKE? OR first_name_kana LIKE? OR
                                  telephone_number LIKE? OR postal_code LIKE? OR address LIKE?',
                                  '%'+@content+'%', '%'+@content+'%', '%'+@content+'%', '%'+@content+'%', '%'+@content+'%', '%'+@content+'%', '%'+@content+'%'])
    elsif @type == 'order_item_all'
      order_records = PreOrder.where(['name LIKE?','%'+@content+'%'])
      item_ids = Item.where(['name LIKE? OR introduction LIKE?','%'+@content+'%','%'+@content+'%'])
      item_records = PreOrder.where(item_id: item_ids)
      @records = order_records + item_records
    elsif @type == 'order_item'
      order_records = PreOrder.search_for(@content, @method)
      item_ids = Item.search_for(@content, @method)
      item_records = PreOrder.where(item_id: item_ids)
      @records = order_records + item_records
    else
    end
  end
end
