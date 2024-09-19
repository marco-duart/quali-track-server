class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :manager
end
