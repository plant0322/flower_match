class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @reviews = Review.all.order(id: 'DESC').page(params[:page])
    @pick_up_tags = PickUpTag.where(is_active: true)
    @tag_rank = Tag.tag_rank_item
    @search = OpenStruct.new(model: 'item')
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      flash[:notice] = "口コミの公開状況を変更しました"
      redirect_to request.referer
    else
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :icon, :is_active)
  end
end
