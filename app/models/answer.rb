class Answer < ApplicationRecord
  belongs_to :evaluation
  belongs_to :question
end
