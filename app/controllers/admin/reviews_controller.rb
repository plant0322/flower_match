class Admin::ReviewsController < ApplicationController
  def index
    @reviews = Review.all.order(id: 'DESC')
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
