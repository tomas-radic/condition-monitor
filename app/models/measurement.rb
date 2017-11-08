class Measurement < ApplicationRecord

  # V A L I D A T I O N S
  validates :measured_at, presence: true

  # R E L A T I O N S
  belongs_to :user
  
end
