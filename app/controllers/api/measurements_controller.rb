class Api::MeasurementsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate

  def create
    last_measurement = Measurement.all.order(measured_at: :desc).first

    # Don't accept new measurement if we have an existing one within last minutes
    timeout_minutes = Rails.configuration.api_measurements_timeout
    if last_measurement.present? && (last_measurement.measured_at > timeout_minutes.minutes.ago)
      render json: { status: 208 } and return
    end

    temperature = params[:temperature].to_f.round.to_i
    humidity = params[:humidity].to_f.round.to_i
    measurement = Measurement.create(
      measured_at: Time.zone.now, 
      temperature: temperature, 
      humidity: humidity,
      user: @user
    )

    if measurement.save
      render json: { status: 200 }
    else
      render json: { status: 400 }
    end
  end


  private

  def authenticate
    @user = User.find_by(email: params[:secret_word])
    render json: { status: 403 } unless @user.present?
  end
end
