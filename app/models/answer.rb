class Answer < ApplicationRecord
  belongs_to :evaluation
  belongs_to :question
  belongs_to :user
end
