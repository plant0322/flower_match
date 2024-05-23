class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :set_current_member, only: [:edit, :update, :withdraw]
  before_action :ensure_guest_member, only: [:edit, :unsubscribe]

  def show
    active_shops = Shop.where(is_active: true)
    @recently_seen_item = Item.find(session[:item_id]) unless session[:item_id].blank?
    bookmarks = Bookmark.where(member_id: current_member.id)
    @bookmark_items = Item.where(id: bookmarks.pluck(:item_id))
                          .where(is_active: true, shop_id: active_shops).order(created_at: "DESC").limit(4)
    active_favorite_shops = FavoriteShop.where(member_id: current_member.id, shop_id: active_shops)
    active_favorite_shops_ids = active_favorite_shops.pluck(:shop_id)
    @favorite_shops = Shop.where(id: active_favorite_shops_ids).order(created_at: "DESC").limit(4)
    @favorite_shop_items = Item.where(is_active: true, shop_id: active_favorite_shops_ids).order(created_at: "DESC").limit(6)
    @tag_rank = Tag.tag_rank_item
  end

  def edit
    @tag_rank = Tag.tag_rank_item
  end

  def update
    if @member.update(member_params)
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to request.referer
    else
      flash[:alert] = "編集内容に誤りがあります"
      redirect_to request.referer
    end
  end

  def unsubscribe
    @tag_rank = Tag.tag_rank_item
  end

  def withdraw
    @member.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  private

  def set_current_member
    @member = current_member
  end

  def ensure_guest_member
    @member = current_member
    if @member.guest_member?
      redirect_to mypage_path, notice: 'お試メンバーのため編集は出来ません。'
    end
  end

  def member_params
    params.require(:member).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :postal_code, :address, :telephone_number)
  end

end
