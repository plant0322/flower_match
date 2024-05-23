class Shop::MessagesController < ApplicationController
 # before_action :block_non_related_member

  def show
    @tag_rank = Tag.tag_rank_item
    @member = Member.find(params[:id])
    room = Room.find_by(shop_id: current_shop.id, member_id: @member)
    unless room.nil?
      @room = room
    else
      @room = Room.new
      @room.shop_id = current_shop.id
      @room.member_id = @member.id
      @room.save
    end
    @messages = @room.member_messages && @room.shop_messages
    @message = ShopMessage.new(room_id: @room.id)
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

  def shop_message_params
    params.require(:shop_message).permit(:message, :room_id)
  end

  def block_non_related_member
    member = Member.find(params[:id])
    if room = Room.find_by(shop_id: current_shop, member_id: member)
      redirect_to root_path
    end
  end
end
