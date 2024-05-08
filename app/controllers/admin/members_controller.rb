class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.update(member_params)
    redirect_to request.referer
  end

  def index
    @members = Member.all
  end

  private

  def member_params
    params.require(:member).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :postal_code, :address, :telephone_number, :is_active)
  end

end
