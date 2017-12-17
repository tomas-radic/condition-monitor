class Phase < ApplicationRecord

  # V A L I D A T I O N S
  validates :product, presence: true
  validates :begin_at, presence: true
  validates :end_at, presence: true, unless: :all_completed?
  validate  :begin_at_not_in_future, :end_at_not_in_future

  # R E L A T I O N S
  belongs_to :product

  # S C O P E S
  scope :in_progress, -> { where.not(begin_at: nil).where('end_at is null or end_at > ?', Time.now) }
  scope :completed, -> { where('end_at <= ?', Time.now) }
  scope :to_end_today, -> { where.not(planned_end_at: nil).where(planned_end_at: (Date.today.beginning_of_day..Date.today.end_of_day))
    .where('end_at is null or end_at > ?', Time.now) 
  }
  scope :missed, -> { where('planned_end_at <= ?', Time.now).where('end_at is null or end_at > ?', Time.now) }

  # C A L L B A C K S
  before_save :set_name


  # Scope related methods
  def in_progress?
    self.begin_at.nil? && (self.end_at.nil? || self.end_at > Time.now)
  end

  def completed?
    self.end_at && (self.end_at <= Time.now)
  end

  def to_end_today?
    self.planned_end_at && self.planned_end_at >= Date.today.beginning_of_day && self.planned_end_at <= Date.today.end_of_day && (self.end_at.nil? || self.end_at > Time.now)
  end

  def missed?
    now = Time.now
    self.planned_end_at && self.planned_end_at <= now && (self.end_at.nil? || self.end_at > now)
  end
  # Scope related methods (end)

  def measurements
    result = self.product.user.measurements.where('measured_at >= ?', self.begin_at)
    result = result.where('measured_at <= ?', self.end_at) if result.any? && self.end_at.present?
    result
  end


  private

  def all_completed?
    Phase.where(product_id: self.product.id, end_at: nil).where.not(id: self.id).count == 0
  end

  def set_name
    self.name = '?' if self.name.blank?
  end

  def begin_at_not_in_future
    errors.add(:begin_at, "is invalid") if !self.begin_at.blank? && self.begin_at > Time.now
  end

  def end_at_not_in_future
    errors.add(:end_at, "is invalid") if !self.end_at.blank? && self.end_at > Time.now
  end
end
