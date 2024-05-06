class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :set_current_member

  def show
  end

  def edit
  end

  def unsubscribe
  end

  private

  def set_current_member
    @member = current_member
  end

end
