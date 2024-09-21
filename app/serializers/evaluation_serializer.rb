class EvaluationSerializer < ActiveModel::Serializer
  attributes :id, :date, :comment, :total_score
  has_one :employee
  has_one :monitor

  has_many :evaluation_questions
  has_many :evaluation_critical_fields
end
