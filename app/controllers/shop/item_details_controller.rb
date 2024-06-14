class Shop::ItemDetailsController < ApplicationController
  def create
    item = Item.find(params[:item_id])
    item_detail = ItemDetail.new(item_detail_params)
    item_detail.item_id = item.id
    if item_detail.save
      flash.now[:notice] = "商品詳細を追加しました"
      redirect_to request.referer
    else
      flash.now[:alert] = "入力内容に誤りがあります"
      redirect_to request.referer
    end
  end

  def update
    item_detail = ItemDetail.find(params[:id])
    if item_detail.update(item_detail_params)
      flash.now[:notice] = "商品詳細を更新しました"
      redirect_to request.referer
    else
      flash.now[:alert] = "入力内容に誤りがあります"
      redirect_to request.referer
    end
  end

  def destroy
    item_detail = ItemDetail.find(params[:id])
    item_detail.destroy
    redirect_to request.referer
    flash[:notice] = "商品詳細を削除しました"
  end

  private

  def item_detail_params
    params.require(:item_detail).permit(:item_detail_image, :introduction, :in_order)
  end
end
