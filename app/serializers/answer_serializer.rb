class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :score, :comment
  has_one :evaluation
  has_one :question
end
