class EvaluationSerializer < ActiveModel::Serializer
  attributes :id, :date, :comment, :total_score
  has_one :employee
  has_one :monitor
end
