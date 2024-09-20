class Question < ApplicationRecord
  has_many :evaluation_questions, dependent: :destroy
  has_many :evaluations, through: :evaluation_questions

  validates :title, presence: true
  validates :description, presence: true
  validates :score, presence: true
end
