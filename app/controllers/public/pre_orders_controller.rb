class Public::PreOrdersController < ApplicationController
  before_action :authenticate_member!
  def new
    @item =  Item.find(params[:item_id])
    @pre_order = PreOrder.new
  end

  def confirm
    @item = Item.find_by(params[:pre_order][:item_id])
    @pre_order = PreOrder.new(pre_order_params)
    if params[:pre_order][:visit_day].blank? || params[:pre_order][:visit_time].blank?  || params[:pre_order][:purpose].blank?
      flash.now[:alert] = '情報を正しく入力して下さい。'
      render :new
    else params[:note].blank?
      @pre_order.note = '特になし'
    end
  end

  def create
    @pre_order = current_member.pre_orders.new(pre_order_params)
    item = Item.find_by(params[:pre_order][:item_id])
    @pre_order.item_id = item.id
    @pre_order.name = item.name
    @pre_order.total_payment = item.price
    @pre_order.last_name = current_member.last_name
    @pre_order.first_name = current_member.first_name
    @pre_order.last_name_kana = current_member.last_name_kana
    @pre_order.first_name_kana = current_member.first_name_kana
    @pre_order.telephone_number = current_member.telephone_number
    @pre_order.postal_code = current_member.postal_code
    @pre_order.address = current_member.address
    @pre_order.buy_day = Time.zone.today
    if @pre_order.save
      redirect_to thanks_path
    else
      render :new
    end
  end

  def error
    @item = Item.find_by(params[:pre_order][:item_id])
    flash.now[:alert] = '問題が発生しました。もう一度情報を入力してください。'
    render :new
  end

  def thanks
  end

  def index
    @pre_orders = current_member.pre_orders
  end

  def show
    @pre_order = PreOrder.find(params[:id])
  end

  private

  def pre_order_params
    params.require(:pre_order).permit(:item_id, :visit_day, :visit_time, :purpose, :note)
  end
end
