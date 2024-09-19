class CriticalFieldSerializer < ActiveModel::Serializer
  attributes :id, :title, :discount_percentage
  has_one :evaluation
end
