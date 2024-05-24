class Public::MessagesController < ApplicationController
  before_action :authenticate_member!
  before_action :block_non_related_member
#  before_action :set_member_shop

  def show
    @tag_rank = Tag.tag_rank_item
    #@shop = Shop.find(params[:id])
    room = Room.find_by(member_id: current_member.id, shop_id: @shop)
    unless room.nil?
      @room = room
    else
      @room = Room.new
      @room.member_id = current_member.id
      @room.shop_id = @shop.id
      @room.save
     # MessageRoom.create(member_id: current_member.id, shop_id: @shop.id, room_id: @room.id)
    end
    @messages = (@room.member_messages + @room.shop_messages).sort_by(&:created_at)
    @message = MemberMessage.new(room_id: @room.id)
  end

  def index
    @tag_rank = Tag.tag_rank_item
    rooms = Room.where(member_id: current_member)
    @messages = ShopMessage.where(room_id: rooms).order(created_at: "DESC").page(params[:page])
    #rooms = Room.where(shop_id: current_shop)
    #shop_messages = ShopMessage.where(room_id: rooms)
    #member_messages = MemberMessage.where(room_id: rooms)
    #@messages = (shop_messages.to_a + member_messages.to_a).uniq
    #@messages = ShopMessage.where(room_id: rooms).order(created_at: "DESC").page(params[:page])
  end

  def create
   # @message = current_member.member_messages.new(member_message_params)
   @message = MemberMessage.new(member_message_params)
   @message.member_id = current_member.id
    if @message.save
      redirect_to request.referer
    else
      flash[:alert] = "送信に失敗しました"
      redirect_to request.referer
    end
  end

  def destroy
    message = MemberMessage.find(params[:id])
    message.destroy
    redirect_to request.referer
  end

  private

 # def set_member_shop
 #   @member = Member.find(params[:member_id])
 #   @shop = Member.find(params[:shop_id])
 # end

  def member_message_params
    params.require(:member_message).permit(:message, :room_id)
  end

  def block_non_related_member
    if room = Room.find_by(member_id: current_member, shop_id: @shop)
      redirect_to root_path
    end
  end
end
