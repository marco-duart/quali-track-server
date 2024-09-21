class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  belongs_to :team, optional: true
  has_many :managed_teams, class_name: 'Team', foreign_key: 'manager_id', dependent: :nullify

  enum role: { employee: 0, monitor: 1, manager: 2, admin: 3 }

  validates :role, presence: true, unless: :new_record?
  validates :team, presence: true, if: :employee?, unless: :new_record?

  before_save :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :employee
  end

  def manager?
    self.role == 'manager'
  end

  def employee?
    self.role == 'employee'
  end

  def monitor?
    self.role == 'monitor'
  end

  def admin?
    self.role == 'admin'
  end
end
