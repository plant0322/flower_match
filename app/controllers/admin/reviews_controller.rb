class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_tag

  def index
    unless params[:content].blank?
      @content = params[:content]
      review_messages = Review.where('content LIKE?','%'+@content+'%').order(id: 'DESC').page(params[:page])
      members = Member.where('last_name LIKE? OR first_name LIKE? OR last_name_kana LIKE? OR first_name_kana LIKE? OR nickname LIKE?',
                                    '%'+@content+'%', '%'+@content+'%', '%'+@content+'%', '%'+@content+'%', '%'+@content+'%')
      member_pre_order_ids = PreOrder.where(member_id: members)
      member_reviews = Review.where(pre_order_id: member_pre_order_ids)
      @reviews = Kaminari.paginate_array((review_messages + member_reviews).uniq.shuffle).page(params[:page])
    else
      @reviews = Review.all.order(id: 'DESC').page(params[:page])
    end
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
