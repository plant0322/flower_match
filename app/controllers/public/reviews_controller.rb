class Public::ReviewsController < ApplicationController
  before_action :set_tag

  def create
    pre_order = PreOrder.find(params[:pre_order_id])
    review = Review.new(review_params)
    review.score = Language.get_data(review_params[:content])
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
    @reviews = Review.active_review.where(pre_order_id: pre_orders)
                                   .order(id: 'DESC').page(params[:page])
    @search = OpenStruct.new(model: 'item')
  end

  private

  def review_params
    params.require(:review).permit(:content, :is_active)
  end
end
