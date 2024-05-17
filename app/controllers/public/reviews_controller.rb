class Public::ReviewsController < ApplicationController
  before_action :authenticate_member!

  def new
    @pre_order = PreOrder.find(params[:pre_order_id])
    @review = Review.new
  end

  def create
    pre_order = PreOrder.find(params[:pre_order_id])
    review = Review.new(review_params)
    review.pre_order_id = pre_order.id
    if review.save
      flash[:notice] = "口コミを投稿しました"
      redirect_to pre_orders_path
    else
      flash[:alert] = "口コミの投稿に失敗しました"
      redirect_to request.referer
    end
  end

  def index
    @pre_orders = PreOrder.where(member_id: current_member.id)
    @review = Review.new
    @tags = Tag.joins(:item_tags).group(:id).order('COUNT(item_tags.tag_id) DESC').limit(10)
  end

  private

  def review_params
    params.require(:review).permit(:content, :icon)
  end
end
