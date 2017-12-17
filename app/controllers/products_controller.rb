class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_product, only: [:show, :edit, :update, :archive]

  def index
    @products_in_progress = current_user.products.in_progress.left_outer_joins(:phases)
      .group('products.id').order('max(phases.begin_at) desc')
    @products_completed = current_user.products.completed.order(produced_at: :desc)
    @products_archived = current_user.products.archived.order(archived_at: :desc)
  end

  def show
    @allow_new_phase = @product.phases.where(end_at: nil).empty?
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
    # loaded in before action callback
  end

  def update
    @product.update(product_params)
    redirect_to @product
  end

  def destroy
  end

  def archive
    @product.archive!
    Measurement.destroy_old
    redirect_to products_path
  end


  private

  def product_params
    params.require(:product).permit(:name, :label, :produced_at, :expiration_at)
  end

  def load_product
    @product = current_user.products.unarchived.find(params[:id])
  end
end
