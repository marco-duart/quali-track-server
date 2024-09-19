class Team < ApplicationRecord
  has_many :users, -> { where(role: :employee) }, class_name: 'User'
  belongs_to :manager, class_name: 'User', foreign_key: 'manager_id'

  validates :name, presence: true
  validates :manager_id, presence: true
end
