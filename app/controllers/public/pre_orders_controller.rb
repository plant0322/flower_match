class Public::PreOrdersController < ApplicationController
  before_action :authenticate_member!

  def new
    @item =  Item.find(params[:item_id])
    if params[:amount].blank?
      flash[:alert] = "個数を選択してください"
      redirect_to item_path(@item)
    end
    @amount =  params[:amount]
    @pre_order = PreOrder.new
  end

  def confirm
    @item = Item.find(params[:pre_order][:item_id])
    @amount =  params[:pre_order][:amount]
    @pre_order = PreOrder.new(pre_order_params)
    if params[:pre_order][:visit_day].blank? || params[:pre_order][:visit_time].blank?  || params[:pre_order][:purpose].blank?
      flash.now[:alert] = '「来店日」「来店時間」「要望・用途」は必須項目です'
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
    @pre_order.amount = params[:pre_order][:amount]
    @pre_order.total_payment = item.price * @pre_order.amount
    @pre_order.last_name = current_member.last_name
    @pre_order.first_name = current_member.first_name
    @pre_order.last_name_kana = current_member.last_name_kana
    @pre_order.first_name_kana = current_member.first_name_kana
    @pre_order.telephone_number = current_member.telephone_number
    @pre_order.postal_code = current_member.postal_code
    @pre_order.address = current_member.address
    @pre_order.buy_day = @pre_order.visit_day
    if @pre_order.save
      item.decrement!(:stock, @pre_order.amount)
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
    @pre_orders = current_member.pre_orders.order(id: "DESC")
    @tags = Tag.joins(:item_tags).group(:id).order('COUNT(item_tags.tag_id) DESC').limit(10)
  end

  def show
    @pre_order = PreOrder.find(params[:id])
    @review = Review.new
    @tags = Tag.joins(:item_tags).group(:id).order('COUNT(item_tags.tag_id) DESC').limit(10)
  end

  private

  def pre_order_params
    params.require(:pre_order).permit(:item_id, :visit_day, :visit_time, :purpose, :note, :amount)
  end
end
