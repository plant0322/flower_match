class Public::PreOrdersController < ApplicationController
  before_action :authenticate_member!
  before_action :is_matching_login_member, only: [:show]
  before_action :set_search, only: [:new, :confirm, :error, :thanks, :index, :show]

  def new
    @item =  Item.find(session[:item_id])
      session[:amount] =  params[:amount]
      @amount = session[:amount].to_i
    if @amount.blank? || @amount == 0
      flash[:alert] = "個数を選択してください"
      redirect_to item_path(@item)
    end
    @pre_order = PreOrder.new
  end

  def confirm
    @amount = session[:amount].to_i
    @item = Item.find(session[:item_id])
    @pre_order = PreOrder.new(pre_order_params)
    if params[:pre_order][:visit_day].blank? || params[:pre_order][:visit_time].blank?  || params[:pre_order][:purpose].blank?
      flash.now[:alert] = '「来店日」「来店時間」「要望・用途」は必須項目です'
      render :new
    elsif params[:pre_order][:visit_day].to_date <  Date.today
      flash.now[:alert] = '今日以前の日付を指定することはできません'
      render :new
    elsif params[:pre_order][:note].blank?
      @pre_order.note = '特になし'
    else
    end
  end

  def create
    @pre_order = current_member.pre_orders.new(pre_order_params)
    item = Item.find(params[:pre_order][:item_id])
    @pre_order.item_id = item.id
    @pre_order.name = item.name
    @pre_order.amount = session[:amount]
    @pre_order.total_payment = item.price * @pre_order.amount
    @pre_order.last_name = current_member.last_name
    @pre_order.first_name = current_member.first_name
    @pre_order.last_name_kana = current_member.last_name_kana
    @pre_order.first_name_kana = current_member.first_name_kana
    @pre_order.telephone_number = current_member.telephone_number
    @pre_order.postal_code = current_member.postal_code
    @pre_order.address = current_member.address
    if @pre_order.save
      item.decrement!(:stock, @pre_order.amount)
      @search = OpenStruct.new(model: 'item')
      render :thanks
    else
      render :new
    end
  end

  def error
    @item = Item.find(session[:item_id])
    @amount = session[:amount].to_i
    @pre_order = PreOrder.new
    flash.now[:alert] = '問題が発生しました。もう一度情報を入力してください。'
    render :new
  end

  def thanks
  end

  def index
    @pre_orders = current_member.pre_orders
    @before_visit_pre_orders = @pre_orders.where(status: 'before_visit').order(visit_day: "ASC")
    @visit_or_cancel_pre_orders = @pre_orders.where(status: ['visit', 'cancel']).order(visit_day: "DESC").page(params[:page])
    @pick_up_tags = PickUpTag.where(is_active: true).order(id: 'DESC')
    @tag_rank = Tag.tag_rank_item
  end

  def show
    @pre_order = PreOrder.find(params[:id])
    @review = Review.new
    @pick_up_tags = PickUpTag.where(is_active: true).order(id: 'DESC')
    @tag_rank = Tag.tag_rank_item
  end

  private

  def set_search
    @search = OpenStruct.new(model: 'item')
  end

  def is_matching_login_member
    pre_order = PreOrder.find(params[:id])
    unless pre_order.member_id == current_member.id
      redirect_to root_path
    end
  end

  def pre_order_params
    params.require(:pre_order).permit(:item_id, :visit_day, :visit_time, :purpose, :note, :amount)
  end
end
