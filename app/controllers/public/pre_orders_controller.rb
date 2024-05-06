class Public::PreOrdersController < ApplicationController
  before_action :authenticate_member!
  def new
    @pre_order = PreOrder.new
    @item_id = params[:item_id]
  end

  def confirm
    @pre_order = PreOrder.new(pre_order_params)
    @item_id = params[:item_id]
    if params[:note].blank?
      @pre_order.note = '特になし'
    end
    if params[:visit_day].blank? || params[:visit_time].blank? || params[:purpose].blank?
      flash[:alert] = '必須項目が入力されていません'
      render :new
    end
  end

  def create
    item = Item.find_by(id: @pre_order.item_id)
    @pre_order.item_id = item.id
    @pre_order.name = item.name
    @pre_order.total_payment = item.price
    @pre_order.last_name = current_member.last_name
    @pre_order.first_name = current_member.first_name
    @pre_order.telephone_number = current_member.telephone_number
    @pre_order = current_member.orders.new(order_params)
    @pre_order.last_name_kana = current_member.last_name_kana
    @pre_order.first_name_kana = current_member.first_name_kana
    @pre_order.postal_code = current_member.postal_code
    @pre_order.address = current_member.address
  end

  def error
  end

  def thanks
  end

  def index
  end

  def show
  end

  def pre_order_params
    params.require(:pre_order).permit(:visit_day, :visit_time, :purpose, :note)
  end
end
