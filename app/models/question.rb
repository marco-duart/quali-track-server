class Question < ApplicationRecord
  belongs_to :evaluation
  has_many :answers, dependent: :destroy
end
