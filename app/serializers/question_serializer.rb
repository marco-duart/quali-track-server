class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :score
end
