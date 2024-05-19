class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def searches
    @type = params[:type]
  end
end
