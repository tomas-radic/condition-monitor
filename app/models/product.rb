class Product < ApplicationRecord

  # V A L I D A T I O N S
  validates :name, presence: true
  validate  :produced_at_not_in_future, :expiration_at_not_in_past

  # R E L A T I O N S
  has_many :phases, dependent: :destroy
  belongs_to :user

  # S C O P E S
  scope :unarchived, -> { where(archived_at: nil) }
  scope :in_progress, -> { unarchived.where(produced_at: nil) }
  scope :completed, -> { unarchived.where.not(produced_at: nil) }
  scope :archived, -> { where.not(archived_at: nil) }


  def full_name
    result = self.name
    result += " (#{self.label})" unless self.label.blank?
    result
  end

  def phases_info
    "#{self.phases.completed.count}/#{self.phases.count}"
  end

  # Scope methods
  def in_progress?
    self.produced_at.nil?
  end

  def completed?
    self.produced_at.present?
  end

  def archived?
    self.archived_at.present?
  end
  # Scope methods (end)


  def archive!
    self.update_attribute(:archived_at, Time.now)
  end


  private

  def produced_at_not_in_future
    errors.add(:produced_at, 'is invalid') if !self.produced_at.blank? && self.produced_at > Time.now
  end

  def expiration_at_not_in_past
    errors.add(:expiration_at, 'is invalid') if !self.expiration_at.blank? && self.expiration_at < Time.now
  end
end
