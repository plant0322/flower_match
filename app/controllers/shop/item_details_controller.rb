class Shop::ItemDetailsController < ApplicationController
  before_action :is_matching_login_shop, only: [:update, :destroy]

  def create
    item = Item.find(params[:item_id])
    item_detail = ItemDetail.new(item_detail_params)
    item_detail.item_id = item.id
    # 画像を圧縮してjpegとwebpで保存
    if params[:item_detail][:item_detail_image].present?
      resized_images = resize_image_set_dpi(params[:item_detail][:item_detail_image])
      original_filename_base = File.basename(params[:item_detail][:item_detail_image].original_filename, ".*")
      item_detail.item_detail_image.attach(
        io: resized_images,
        filename: "#{original_filename_base}.jpg",
        content_type: 'image/jpg'
        )
    # visionのデータを取得
    item_checks = Vision.get_image_data(item_detail_params[:item_detail_image])
    end

    if item_detail.save
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

        item_check = ItemCheck.find_by(item_id: item.id)

        if flower_found || plant_found
          item_check.label_check = true
          item_check.permission = 0
        else
          item_check.label_check = false
          item_check.permission = 1
          item.update(is_active: false)
        end
        item_check.save
      end

      flash[:notice] = "商品詳細を追加しました"
      puts 'aaa'
      redirect_to request.referer
    else
      flash[:alert] = "入力内容に誤りがあります"
      puts 'bbb'
      redirect_to request.referer
    end
  end

  def update
    item_detail = ItemDetail.find(params[:id])
    # 画像を圧縮してjpegとwebpで保存
    if params[:item_detail][:item_detail_image].present?
      resized_images = resize_image_set_dpi(params[:item_detail][:item_detail_image])
      original_filename_base = File.basename(params[:item_detail][:item_detail_image].original_filename, ".*")
      item_detail.item_detail_image.attach(
        io: resized_images,
        filename: "#{original_filename_base}.jpg",
        content_type: 'image/jpg'
        )
    end
    # visionのデータを取得
    if params[:item_detail][:item_detail_image]
      item_checks = Vision.get_image_data(item_detail_params[:item_detail_image])
    end

    if item_detail.update(item_detail_params)
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

        item_check = ItemCheck.find_by(item_id: params[:item_id])

        if flower_found || plant_found
          item_check.label_check = true
          item_check.permission = 0
        else
          item_check.label_check = false
          item_check.permission = 1
          item.update(is_active: false)
        end
        item_check.save
      end

      flash[:notice] = "商品詳細を更新しました"
      redirect_to request.referer
    else
      flash[:alert] = "入力内容に誤りがあります"
      redirect_to request.referer
    end
  end

  def destroy
    item_detail = ItemDetail.find(params[:id])
    item_detail.destroy
    redirect_to request.referer
    flash[:notice] = "商品詳細を削除しました"
  end

  private

  def is_matching_login_shop
    item = Item.find(params[:item_id])
    unless item.shop_id == current_shop.id
      redirect_to shop_top_path
    end
  end

  def resize_image_set_dpi(uploaded_file)
    image = MiniMagick::Image.read(uploaded_file.tempfile)
    image.resize 'x1350'
    image.density '96'

    tempfile_jpg = Tempfile.new('resized')
    image.write (tempfile_jpg.path)
    tempfile_jpg.rewind
    tempfile_jpg
  end

  def item_detail_params
    params.require(:item_detail).permit(:item_detail_image, :introduction, :in_order)
  end
end
