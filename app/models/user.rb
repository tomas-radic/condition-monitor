class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Roles
  enum roles: [:admin, :demo]

  # Validations
  validates :email, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  # Relations
  has_many :products, dependent: :destroy
  has_many :measurements, dependent: :destroy

  # Callbacks
  before_validation :strip_whitespaces

  # Scopes
  scope :admins, -> { where(id: all.select { |u| u.has_role?('admin') }.map { |u| u.id }) }
  scope :demos, -> { where(id: all.select { |u| u.has_role?('demo') }.map { |u| u.id }) }


  #####################################
  # About Roles:
  # User roles are determined by attribute 'role', 64bit integer where each bit corresponds 
  # with one role from 'roles' enum. First bit (most right one) = first role in enum etc.

  # Adds role given by role name to user, returns true if success, false otherwise.
  def add_role(role_name)
    return false unless User.roles.keys.include?(role_name)
    r = User.roles[role_name]
    self.role |= (1 << r)
    self.save
  end

  # Removes role given by role name from user, returns true if success, false otherwise.
  def remove_role(role_name)
    return false unless User.roles.keys.include?(role_name)
    r = User.roles[role_name]
    self.role ^= (1 << r)
    self.save
  end

  # Returns true if user has role given by name, false otherwise.
  def has_role?(role_name)
    return false unless User.roles.keys.include?(role_name)
    r = User.roles[role_name]
    self.role & (1 << r) != 0
  end

  # Returns calculated integer describing user roles based on given role names.
  def User.calculate_role(role_names = [])
    result = 0
    role_names.reject! { |rn| !User.roles.include?(rn) }

    role_names.each do |rn|
      r = User.roles[rn]
      result |= (1 << r)
    end

    result
  end


  private

  def strip_whitespaces
    self.email.strip! unless self.email.blank?
  end
end
