class Shop::MessagesController < ApplicationController
  before_action :authenticate_shop!
  before_action :set_tag_rank, only: [:show, :index]
  before_action :block_non_related_shop, only: [:show, :create, :destroy]

  def show
    @room = Room.find(params[:id])
    @messages = (@room.member_messages + @room.shop_messages).sort_by(&:created_at)
    @message = ShopMessage.new(room_id: @room.id)
  end

  def index
    rooms = Room.where(shop_id: current_shop)
    @messages = MemberMessage.where(room_id: rooms).order(created_at: "DESC").page(params[:page])
  end

  def create
   @message = ShopMessage.new(shop_message_params)
   @message.shop_id = current_shop.id
    if @message.save
      redirect_to request.referer
    else
      flash[:alert] = "送信に失敗しました"
      redirect_to request.referer
    end
  end

  def destroy
    message = ShopMessage.find(params[:id])
    message.destroy
    redirect_to request.referer
  end

  private

  def set_tag_rank
    @tag_rank = Tag.tag_rank_item
  end

  def shop_message_params
    params.require(:shop_message).permit(:message, :room_id)
  end

  def block_non_related_shop
    room = Room.find(params[:id])
    if room.shop_id != current_shop.id
      redirect_to root_path
    end
  end
end
