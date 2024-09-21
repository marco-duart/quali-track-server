class EvaluationCriticalFieldSerializer < ActiveModel::Serializer
  attributes :id, :evaluation_id, :critical_field_id
  has_one :evaluation
  has_one :critical_field
end
