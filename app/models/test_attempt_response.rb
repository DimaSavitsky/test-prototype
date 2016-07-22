class TestAttemptResponse < ApplicationRecord

  belongs_to :test_attempt
  belongs_to :question
  belongs_to :question_response

  validates :question_id, uniqueness: { scope: :test_attempt_id }

  validate :question_belong_to_test

  private

  def question_belong_to_test
    if (self.question.test.id != self.test_attempt.test_id ) || ( self.question_id != self.question_response.question_id )
      errors.add(:base, 'Something is off')
    end
  end

end
