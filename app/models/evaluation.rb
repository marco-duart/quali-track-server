class Evaluation < ApplicationRecord
  belongs_to :employee, class_name: 'User'
  belongs_to :monitor, class_name: 'User'
  belongs_to :team

  has_many :evaluation_questions, dependent: :destroy
  has_many :questions, through: :evaluation_questions
  has_many :answers, through: :questions
  has_many :evaluation_critical_fields, dependent: :destroy
  has_many :critical_fields, through: :evaluation_critical_fields
  has_many :signatures, dependent: :destroy

  validate :must_have_signatures

  private

  def must_have_signatures
    return unless signatures.where(status: :signed).count < 2

    errors.add(:base, 'A avaliação deve ter assinatura do manager e do employee.')
  end
end
