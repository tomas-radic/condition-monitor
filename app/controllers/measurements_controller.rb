class MeasurementsController < ApplicationController
  before_action :authenticate_user!

  def index
    @date = Date.today
    @date = Date.parse(params[:date]) unless params[:date].blank?
    @measurements = current_user.measurements
      .where('measured_at >= ? and measured_at <= ?', @date.beginning_of_day, @date.end_of_day)
      .order(measured_at: :desc)
  end
end
