class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :score
  has_one :evaluation
end
