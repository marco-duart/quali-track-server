class SignatureSerializer < ActiveModel::Serializer
  attributes :id, :status, :signed_at
  has_one :evaluation
  has_one :user
end
