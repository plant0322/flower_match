class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :set_current_member

  def show
  end

  def edit
  end

  def update
    @member = Member.update(member_params)
    redirect_to request.referer
  end

  def unsubscribe
  end

  def withdraw
    @member = Member.update(is_active: false)
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
