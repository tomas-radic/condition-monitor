class HomeController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @products_inside_fridge = current_user.products.in_progress.joins(:phases).merge(Phase.in_progress).distinct
    @products_outside_fridge = current_user.products.in_progress.where.not(id: @products_inside_fridge.ids)
  end
end
