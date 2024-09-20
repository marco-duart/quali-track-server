class EvaluationCriticalField < ApplicationRecord
  belongs_to :evaluation
  belongs_to :critical_field

  validates :evaluation_id, presence: true
  validates :critical_field_id, presence: true
end
