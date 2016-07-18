class TestVariable < ApplicationRecord

  belongs_to :test, optional: true
  has_many :questions, dependent: :destroy
  has_one :test_result, dependent: :destroy

  validates :name, { presence: true, uniqueness: { scope: :test } }

  def max_value
    self.questions.includes(:question_responses).sum do |question|
      question.question_responses.maximum(:points) || 0
    end
  end

  def results_complete?
    self.test_result.present? && self.test_result.covers?(max_value)
  end
end
