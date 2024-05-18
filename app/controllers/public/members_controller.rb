class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :set_current_member, only: [:edit, :update]

  def show
    bookmarks = Bookmark.where(member_id: current_member.id)
    @bookmark_items = Item.where(id: bookmarks.pluck(:item_id)).order(created_at: "DESC").limit(3)
    favorite_shops = FavoriteShop.where(member_id: current_member.id)
    shop_ids = favorite_shops.pluck(:shop_id)
    @favorite_shop_items = Item.where(shop_id: shop_ids).order(created_at: "DESC").limit(6)
    @tags = Tag.joins(:item_tags).group(:id).order('COUNT(item_tags.tag_id) DESC').limit(10)
  end

  def edit
    @tags = Tag.joins(:item_tags).group(:id).order('COUNT(item_tags.tag_id) DESC').limit(10)
  end

  def update
    if @member.update(member_params)
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to request.referer
    else
      flash[:alert] = @member.errors.full_messages
      redirect_to request.referer
    end
  end

  def unsubscribe
    @tags = Tag.joins(:item_tags).group(:id).order('COUNT(item_tags.tag_id) DESC').limit(10)
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

  def member_params
    params.require(:member).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :postal_code, :address, :telephone_number)
  end

end
