class EvaluationQuestionSerializer < ActiveModel::Serializer
  attributes :id, :evaluation_id, :question_id
  has_one :evaluation
  has_one :question
end
