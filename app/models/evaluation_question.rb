class EvaluationQuestion < ApplicationRecord
  belongs_to :evaluation
  belongs_to :question

  validates :evaluation_id, presence: true
  validates :question_id, presence: true
end
