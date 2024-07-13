class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :set_current_member, only: [:edit, :update, :withdraw]
  before_action :ensure_guest_member, only: [:edit, :unsubscribe]
  before_action :set_search, only: [:show, :edit, :unsubscribe]
  before_action :set_tag

  def show
    @before_visit_pre_order = PreOrder.where(status: 'before_visit', member_id: current_member)
    visit_pre_orders = PreOrder.where(status: 'visit', member_id: current_member)
                               .where('visit_day >= ?', 2.week.ago)
    reviews = Review.where(pre_order_id: visit_pre_orders)
    @pre_orders = PreOrder.where(id: visit_pre_orders)
                          .where.not(id: reviews.pluck(:pre_order_id))
    @recently_seen_item = Item.find(session[:item_id]) unless session[:item_id].blank?

    bookmarks = Bookmark.where(member_id: current_member.id)
    @bookmark_items = Item.active.active_shop
                          .where(id: bookmarks.pluck(:item_id))
                          .order(created_at: "DESC").limit(4)

    active_shops = Shop.active_shop
    active_favorite_shop_ids = FavoriteShop.where(member_id: current_member.id, shop_id: active_shops).pluck(:shop_id)
    @favorite_shops = Shop.where(id: active_favorite_shop_ids).order(created_at: "DESC").limit(4)
    @favorite_shop_items = Item.active.where(shop_id: active_favorite_shop_ids).order(created_at: "DESC").limit(6)
  end

  def edit
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
  end

  def withdraw
    @member.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  private

  def set_search
    @search = OpenStruct.new(model: 'item')
  end

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
    params.require(:member).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :postal_code, :address, :telephone_number, :email)
  end

end
