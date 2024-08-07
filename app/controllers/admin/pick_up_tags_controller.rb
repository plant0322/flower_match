class Admin::PickUpTagsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_tag

  def create
    @pick_up_tag = PickUpTag.new(pick_up_tag_params)
    if @pick_up_tag.save
      flash[:notice] = "イベントを作成しました"
      redirect_to pick_up_tag_path(@pick_up_tag)
    else
      flash[:alert] = "入力内容に誤りがあります"
      redirect_to admin_tags_path
    end
  end

  def edit
    @tags = Tag.all
    @pick_up_tag = PickUpTag.find(params[:id])
    @search = OpenStruct.new(model: 'item')
  end

  def update
    pick_up_tag = PickUpTag.find(params[:id])
    if pick_up_tag.update(pick_up_tag_params)
      flash[:notice] = "イベント内容を更新しました"
      redirect_to request.referer
    else
      flash[:alert] = "編集内容に誤りがあります"
      redirect_to request.referer
    end
  end

  def destroy
    pick_up_tag = PickUpTag.find(params[:id])
    pick_up_tag.destroy
    redirect_to admin_tags_path
    flash[:notice] = "イベントを削除しました"
  end

  private

  def pick_up_tag_params
    params.require(:pick_up_tag).permit(:tag_id, :name, :introduction, :is_active, :tag_image, :in_order)
  end
end
