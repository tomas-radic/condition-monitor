class PhasesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_product, only: [:show, :new, :create, :edit, :update]

  def show
    @phase = @product.phases.find(params[:id])
  end

  def new
    @phase = @product.phases.new
  end

  def create
    @phase = @product.phases.new(phase_params)
    @phase.begin_at = DateTime.now
    @phase.save
    redirect_to product_path(@product)
  end

  def edit
    @phase = @product.phases.find(params[:id])
  end

  def update
    @phase = @product.phases.find(params[:id])
    @phase.update(phase_params)
    redirect_to product_path(@product)
  end

  def destroy

  end


  private

  def phase_params
    params.require(:phase).permit(
      :name, :begin_at, :end_at, :planned_end_at
    )
  end

  def load_product
    @product = current_user.products.find(params[:product_id])
  end
end
