class Shop::HomesController < ApplicationController
  before_action :authenticate_shop!
  
  def top
  end
end
