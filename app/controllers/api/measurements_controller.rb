class Api::MeasurementsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate

  SECRET_WORD = 'bravcoverebra'

  def create
    temperature = params[:temperature].to_f.round.to_i
    humidity = params[:humidity].to_f.round.to_i
    measurement = Measurement.create(
      measured_at: Time.zone.now, 
      temperature: temperature, 
      humidity: humidity,
      user: User.find_by(email: 'bravcove@plece.com')
    )

    if measurement.save
      render json: { status: 200 }
    else
      render json: { status: 400 }
    end
  end


  private

  def authenticate
    render json: { status: 403 } unless params[:secret_word].eql?(SECRET_WORD)
  end
end
