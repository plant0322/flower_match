class Shop::ItemsController < ApplicationController
  before_action :authenticate_shop!, except: [:destroy]
  before_action :set_item, only: [:edit, :update, :destroy]
  before_action :is_matching_login_shop, only: [:edit, :update, :destroy]
  before_action :set_tag_rank, only: [:edit, :index, :new, :create]

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @tag_list = @item.tags.pluck(:name).join(',')
    @item.shop_id = current_shop.id
    tag_list = params[:item][:tag_name].split(',')
    # 画像を圧縮してjpegとwebpで保存
    if params[:item][:item_image].present?
      resized_images = resize_image_set_dpi(params[:item][:item_image])
      original_filename_base = File.basename(params[:item][:item_image].original_filename, ".*")
      @item.item_image.attach(
        io: resized_images,
        filename: "#{original_filename_base}.jpg",
        content_type: 'image/jpg'
        )
      #@item.item_image_webp.attach(
        #io: resized_images[:webp],
        #filename: "#{original_filename_base}.webp",
        #content_type: 'image/webp'
        #)
    end
    # visionのデータを取得
    item_checks = Vision.get_image_data(item_params[:item_image])

    if @item.save
      # visionで取得したデータを使って画像の関連度判定
      plant_found = false
      flower_found = false

      item_checks.each do |check|
        if check[:description].include?("Plant") && check[:topicality] >= 0.8
          plant_found = true
        elsif check[:description].include?("Flower") && check[:topicality] >= 0.8
          flower_found = true
        end
      end

      item_check = ItemCheck.new
      item_check.item_id = @item.id

      if flower_found || plant_found
        item_check.label_check = true
        item_check.permission = 0
        # 商品を初めて公開した場合の設定
        if params[:item][:first_is_active] == 'true'
          @item.update(is_active: true)
        end
      else
        item_check.label_check = false
        item_check.permission = 1
        @item.update(first_is_active: false)
      end
      item_check.save

      @item.save_tags(tag_list)
      flash[:notice] = "商品を登録しました"
      redirect_to item_path(@item)
    else
      flash.now[:alert] = "入力内容に誤りがあります"
      render :new
    end
  end

  def index
    @shop = Shop.find(current_shop.id)
    @items = @shop.items.order(id: 'DESC').page(params[:page])
  end

  def edit
    @tag_list = @item.tags.pluck(:name).join(',')
  end

  def update
    tag_list = params[:item][:tag_name].split(',')
    # 画像を圧縮してjpegとwebpで保存
    if params[:item][:item_image].present?
      resized_images = resize_image_set_dpi(params[:item][:item_image])
      original_filename_base = File.basename(params[:item][:item_image].original_filename, ".*")
      @item.item_image.attach(
        io: resized_images,
        filename: "#{original_filename_base}.jpg",
        content_type: 'image/jpg'
        )
      #@item.item_image_webp.attach(
        #io: resized_images[:webp],
        #filename: "#{original_filename_base}.webp",
        #content_type: 'image/webp'
        #)
    end
    # visionのデータを取得
    if params[:item][:item_image]
      item_checks = Vision.get_image_data(item_params[:item_image])
    end

    if @item.update(item_params)
      # visionで取得したデータを使って画像の関連度判定
      if item_checks
        plant_found = false
        flower_found = false

        item_checks.each do |check|
          if check[:description].include?("Plant") && check[:topicality] >= 0.8
            plant_found = true
          elsif check[:description].include?("Flower") && check[:topicality] >= 0.8
            flower_found = true
          end
        end

        item_check = ItemCheck.find_by(item_id: @item.id)

        if flower_found || plant_found
          item_check.label_check = true
          item_check.permission = 0
          # 商品を初めて公開した場合の設定
          if params[:item][:first_is_active] == 'true'
            @item.update(is_active: true)
          end
        else
          item_check.label_check = false
          item_check.permission = 1
          @item.update(is_active: false)
        end
        item_check.save
      end

      @item.save_tags(tag_list)

      flash[:notice] = "商品情報を更新しました"
      redirect_to request.referer
    else
      flash[:alert] = "編集内容に誤りがあります"
      redirect_to request.referer
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to shop_items_path
    flash[:notice] = "商品を削除しました"
  end

  private

  def is_matching_login_shop
    item = Item.find(params[:id])
    unless item.shop_id == current_shop.id
      redirect_to shop_top_path
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_tag_rank
    @pick_up_tags = PickUpTag.where(is_active: true).order(id: 'DESC')
    @tag_rank = Tag.tag_rank_item
    @search = OpenStruct.new(model: 'item')
  end

  def resize_image_set_dpi(uploaded_file)
    image = MiniMagick::Image.read(uploaded_file.tempfile)
    image.resize 'x1350'
    image.density '96'

    #tempfile_jpg = Tempfile.new(['resized','.jpg'])
    tempfile_jpg = Tempfile.new('resized')
    image.write (tempfile_jpg.path)
    tempfile_jpg.rewind
    tempfile_jpg

    #tempfile_webp = Tempfile.new(['resized', '.webp'])
    #image.format 'webp'
    #image.write(tempfile_webp.path)
    #tempfile_webp.rewind

    #{ jpg: tempfile_jpg, webp: tempfile_webp }
  end

  def item_params
    params.require(:item).permit(:item_image, :name, :introduction, :size, :price, :stock, :deadline, :is_active, :first_is_active)
  end
end
