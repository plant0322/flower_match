class Admin::PickUpTagsController < ApplicationController
  before_action :authenticate_admin!

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
    @pick_up_tags = PickUpTag.where(is_active: true)
    @tag_rank = Tag.tag_rank_item
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

  private

  def pick_up_tag_params
    params.require(:pick_up_tag).permit(:tag_id, :name, :introduction, :is_active, :tag_image)
  end
end
