class Public::ReviewsController < ApplicationController

  #def new
    #@pre_order = PreOrder.find(params[:pre_order_id])
    #@review = Review.new
  #end

  def create
    pre_order = PreOrder.find(params[:pre_order_id])
    review = Review.new(review_params)
    review.pre_order_id = pre_order.id
    if review.save
      flash[:notice] = "口コミを投稿しました"
      redirect_to pre_orders_path
    else
      flash[:alert] = "口コミの投稿は300文字以内となっています"
      redirect_to request.referer
    end
  end

  def index
    @shop = Shop.find(params[:shop_id])
    items = @shop.items
    pre_orders = PreOrder.where(item_id: items)
    @reviews = Review.where(pre_order_id: pre_orders)
                     .where(is_active: true).order(id: 'DESC').page(params[:page])
    @pick_up_tags = PickUpTag.where(is_active: true).order(id: 'DESC')
    @tag_rank = Tag.tag_rank_item
    @search = OpenStruct.new(model: 'item')
  end

  private

  def review_params
    params.require(:review).permit(:content, :icon, :is_active)
  end
end
