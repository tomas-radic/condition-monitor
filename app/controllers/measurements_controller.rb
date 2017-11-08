class MeasurementsController < ApplicationController
  before_action :authenticate_user!

  def index
    @measurements = current_user.measurements.all.order(measured_at: :desc)
  end
end
