class Shop::MessagesController < ApplicationController
  before_action :set_tag_rank, only: [:show, :index]
  before_action :block_non_related_shop, only: [:show, :destroy]

  def show
    @room = Room.find(params[:id])
    @messages = (@room.member_messages + @room.shop_messages).sort_by(&:created_at).sort { |a, b| b.created_at <=> a.created_at }
    @message = ShopMessage.new(room_id: @room.id)
  end

  def index
    @rooms = Room.where(shop_id: current_shop)
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
      @messages.sort_by!(&:created_at)
    end
    #@messages = MemberMessage.where(room_id: rooms).order(created_at: "DESC").page(params[:page])
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
      if @message.is_a?(MemberMessage)
        Room.find_by(id: @message.room_id).update(is_take_care: false)
      end
      redirect_to request.referer
    else
      flash[:alert] = "送信に失敗しました"
      redirect_to request.referer
    end
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      flash[:notice] = "更新しました"
      redirect_to request.referer
    else
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

  def room_params
    params.require(:room).permit(:is_take_care)
  end

  def block_non_related_shop
    room = Room.find(params[:id])
    if (shop_signed_in? && room.shop_id != current_shop.id) || (member_signed_in? && room.member_id != current_member.id)
      redirect_to root_path
    end
  end
end
