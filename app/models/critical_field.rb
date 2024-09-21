class CriticalField < ApplicationRecord
  has_many :evaluation_critical_fields, dependent: :destroy
  has_many :evaluations, through: :evaluation_critical_fields

  validates :title, presence: true
  validates :discount_percentage, presence: true
end
