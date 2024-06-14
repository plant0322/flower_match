class Shop::ShopsController < ApplicationController
  before_action :authenticate_shop!
  before_action :set_current_shop_tag
  before_action :ensure_guest_shop, only: [:edit, :unsubscribe]

  def edit
  end

  def update
    # 画像を圧縮して保存
    if params[:shop][:shop_image].present?
      resized_image = resize_image_set_dpi(params[:shop][:shop_image])
      original_filename_base = File.basename(params[:shop][:shop_image].original_filename, ".*")
      @shop.shop_image.attach(
        io: resized_image,
        filename: "#{original_filename_base}.jpg",
        content_type: params[:shop][:shop_image].content_type
        )
    end

    if @shop.update(shop_params)
      flash[:notice] = "ショップ情報を更新しました"
      redirect_to request.referer
    else
      flash[:alert] = "編集内容に誤りがあります"
      redirect_to request.referer
    end
  end

  def unsubscribe
  end

  def withdraw
    @shop.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  private

  def set_current_shop_tag
    @shop = current_shop
    @pick_up_tags = PickUpTag.where(is_active: true).order(in_order: 'ASC')
    @tag_rank = Tag.tag_rank_item
    @search = OpenStruct.new(model: 'item')
  end

  def ensure_guest_shop
    @shop = current_shop
    if @shop.guest_shop?
      redirect_to shop_top_path, notice: 'お試しショップのため編集は出来ません。'
    end
  end

  def resize_image_set_dpi(uploaded_file)
    image = MiniMagick::Image.read(uploaded_file.tempfile)
    image.resize 'x1080'
    image.density '96'
    tempfile = Tempfile.new(['resized','.jpg'])
    image.write (tempfile.path)
    tempfile.rewind
    tempfile
  end

  def shop_params
    params.require(:shop).permit(:shop_image, :name, :name_kana, :introduction, :representative_name, :postal_code, :prefecture_code, :address, :opening_hour, :holiday, :parking, :note, :payment_method, :direction, :telephone_number)
  end
end
