class Shop::MessagesController < ApplicationController
  before_action :set_tag_rank, only: [:show, :index]
  before_action :block_non_related_shop, only: [:show, :destroy]

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
    if shop_signed_in?
      @message = ShopMessage.new(shop_message_params)
      @message.shop_id = current_shop.id
    elsif member_signed_in?
      @message = MemberMessage.new(shop_message_params)
      @message.member_id = current_member.id
    end
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
    if (shop_signed_in? && room.shop_id != current_shop.id) || (member_signed_in? && room.member_id != current_member.id)
      redirect_to root_path
    end
  end
end
