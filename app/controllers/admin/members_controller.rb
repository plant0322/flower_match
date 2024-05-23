class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_member, only: [:show, :edit, :update]
  def show
    member_pre_orders = PreOrder.where(member_id: @member)
    @before_visit_pre_orders = member_pre_orders.where(status: 'before_visit')
    @visit_or_cancel_pre_orders = member_pre_orders.where(status: 'visit') + member_pre_orders.where(status: 'cancel')
    @reviews = Review.where(pre_order_id: member_pre_orders)
  end

  def edit
  end

  def update
    if @member.update(member_params)
      flash[:notice] = "会員ステータスを変更しました"
      redirect_to request.referer
    else
      render :edit
    end
  end

  def index
    unless params[:content].blank?
      @content = params[:content]
      @members = Member.where('last_name LIKE? OR first_name LIKE? OR last_name_kana LIKE? OR first_name_kana LIKE? OR
                               telephone_number LIKE? OR postal_code LIKE? OR address LIKE?',
                               "%#{@content}%", "%#{@content}%", "%#{@content}%", "%#{@content}%", "%#{@content}%", "%#{@content}%", "%#{@content}%").order(id: 'DESC')#.page(params[:page])
    else
      @members = Member.all.order(id: 'DESC').page(params[:page])
    end
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :postal_code, :address, :telephone_number, :is_active)
  end

end
