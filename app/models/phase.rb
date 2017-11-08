class Phase < ApplicationRecord

  # V A L I D A T I O N S
  validates :product, presence: true
  validates :begin_at, presence: true
  validates :end_at, presence: true, unless: :all_completed?

  # R E L A T I O N S
  belongs_to :product

  # S C O P E S
  scope :completed, -> { where.not(end_at: nil) }

  # C A L L B A C K S
  before_save :set_name


  def completed?
    self.end_at.present?
  end

  def measurements
    result = self.product.user.measurements.where('measured_at >= ?', self.begin_at)
    result = result.where('measured_at <= ?', self.end_at) if self.completed?
    result
  end


  private

  def all_completed?
    Phase.where(product_id: self.product.id, end_at: nil).where.not(id: self.id).count == 0
  end

  def set_name
    self.name = '?' if self.name.blank?
  end
end
