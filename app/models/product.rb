class Product < ApplicationRecord

  # V A L I D A T I O N S
  validates :name, presence: true

  # R E L A T I O N S
  has_many :phases, dependent: :destroy
  belongs_to :user

  # S C O P E S
  scope :in_progress, -> { where(produced_at: nil) }
  scope :completed, -> { where.not(produced_at: nil) }

end
