class Team < ApplicationRecord
  has_many :users, -> { where(role: :employee) }, class_name: 'User', dependent: :nullify
  belongs_to :manager, class_name: 'User', foreign_key: 'manager_id'

  validates :name, presence: true
  validates :manager_id, presence: true
  validate :manager_role_must_be_manager

  def manager_role_must_be_manager
    errors.add(:manager, 'must be a manager') if manager && !manager.manager?
  end
end
