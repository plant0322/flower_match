class Shop::PreOrdersController < ApplicationController
  before_action :authenticate_admin_or_shop!
  before_action :set_search, only: [:show, :index]
  before_action :set_tag

  def index
    @shop = current_shop
    @shop_items = Item.where(shop_id: @shop.id)
    @pre_orders = PreOrder.where(item_id: @shop_items.pluck(:id))
    @before_visit_pre_orders = @pre_orders.where(status: 'before_visit')
                                          .order(visit_day: "ASC")
    @visit_or_cancel_pre_orders = @pre_orders.where(status: ['visit', 'cancel'])
                                             .order(visit_day: "DESC").page(params[:page])
    @search_order = OpenStruct.new(type: 'order_member')
  end

  def show
    @pre_order = PreOrder.find(params[:id])
  end

  def update
    @pre_order = PreOrder.find(params[:id])
    @pre_order.update(pre_order_params)
    flash[:notice] = '予約状況を変更しました'
    redirect_to shop_pre_order_path(@pre_order)
  end

  private

  def authenticate_admin_or_shop!
    unless shop_signed_in? || admin_signed_in?
      redirect_to root_path
    end
  end

  def set_search
    @search = OpenStruct.new(model: 'item')
  end

  def pre_order_params
    params.require(:pre_order).permit(:status, :visit_day, :visit_time)
  end

end
