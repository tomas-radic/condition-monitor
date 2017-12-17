class HomeController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @products_in_fridge = current_user.products.in_progress.joins(:phases).merge(Phase.in_progress).distinct
    @products_out_of_fridge = current_user.products.in_progress.where.not(id: @products_in_fridge.ids)
  end
end
