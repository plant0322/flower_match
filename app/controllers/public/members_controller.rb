class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :set_current_member

  def show
  end

  def edit
  end

  def update
    if @member.update(member_params)
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to request.referer
    else
      flash.now[:alert] = "ユーザー情報の更新に失敗しました"
      render :edit
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

  def set_current_member
    @member = current_member
  end

  def member_params
    params.require(:member).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :postal_code, :address, :telephone_number)
  end

end
