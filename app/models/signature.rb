class Signature < ApplicationRecord
  belongs_to :evaluation
  belongs_to :manager, class_name: 'User', optional: true
  belongs_to :employee, class_name: 'User', optional: true

  enum status: { pending: 'pending', signed: 'signed', contested: 'contested' }
end
