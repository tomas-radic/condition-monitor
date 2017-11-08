class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products_in_progress = current_user.products.in_progress.order(created_at: :desc)
    @products_completed = current_user.products.completed.order(produced_at: :desc)
  end

  def show
    @product = current_user.products.find(params[:id])
  end

  def new
    @product = current_user.products.new
  end

  def create
    @product = current_user.products.new(product_params)
    @product.save
    redirect_to @product
  end

  def edit
    @product = current_user.products.find(params[:id])
  end

  def update
    @product = current_user.products.find(params[:id])
    @product.update(product_params)
    redirect_to @product
  end

  def destroy
  end


  private

  def product_params
    params.require(:product).permit(:name, :label, :produced_at, :expiration_at)
  end
end
