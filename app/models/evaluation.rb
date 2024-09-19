class Evaluation < ApplicationRecord
  belongs_to :employee, class_name: 'User'
  belongs_to :monitor, class_name: 'User'
  
  has_many :questions, dependent: :destroy
  has_many :answers, through: :questions
  has_many :critical_fields, dependent: :destroy
end
