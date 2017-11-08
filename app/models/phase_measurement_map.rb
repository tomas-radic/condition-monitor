class PhaseMeasurementMap < ApplicationRecord

  # V A L I D A T I O N S
  validates :phase, :measurement, presence: true

  # R E L A T I O N S
  belongs_to :phase
  belongs_to :measurement
  
end
