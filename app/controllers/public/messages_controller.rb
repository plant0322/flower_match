class Public::MessagesController < ApplicationController
  before_action :authenticate_member!
  before_action :block_non_related_member
  before_action :set_tag_rank, only: [:show, :index]

  def show
    @shop = Shop.find(params[:id])
    room = Room.find_by(member_id: current_member, shop_id: @shop)
    unless room.nil?
      @room = room
    else
      @room = Room.new
      @room.member_id = current_member.id
      @room.shop_id = @shop.id
      @room.save
    end
    @messages = (@room.member_messages + @room.shop_messages).sort_by(&:created_at)
    @message = MemberMessage.new(room_id: @room.id)
  end

  def index
    @rooms = Room.where(member_id: current_member)
    @messages = []

    @rooms.each do |room|
      new_member_message = MemberMessage.where(room_id: room.id).order(created_at: "DESC").first
      new_shop_message = ShopMessage.where(room_id: room.id).order(created_at: "DESC").first

      if new_member_message && new_shop_message
        new_message = [new_member_message, new_shop_message].max_by(&:created_at)
        @messages << new_message
      elsif new_member_message
        @messages << new_member_message
      elsif new_shop_message
        @messages << new_shop_message
      end
      @messages.sort! { |a, b| b.created_at <=> a.created_at }
    end
  end

  def create
   @message = MemberMessage.new(member_message_params)
   @message.member_id = current_member.id
    if @message.save
      Room.find_by(id: @message.room_id).update(is_take_care: false)
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

  def set_tag_rank
    @pick_up_tags = PickUpTag.where(is_active: true).order(id: 'DESC')
    @tag_rank = Tag.tag_rank_item
    @search = OpenStruct.new(model: 'item')
  end

  def member_message_params
    params.require(:member_message).permit(:message, :room_id)
  end

  def block_non_related_member
    if room = Room.find_by(member_id: current_member, shop_id: @shop)
      redirect_to root_path
    end
  end
end
