class Team < ApplicationRecord
  has_many :users, -> { where(role: :employee) }, class_name: 'User'
  belongs_to :manager, class_name: 'User'
end
