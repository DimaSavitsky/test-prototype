class TestAttempt < ApplicationRecord

  belongs_to :user
  belongs_to :test

  has_many :test_attempt_responses, dependent: :destroy

  after_initialize :set_attempt_params

  scope :for_user, ->(user) { where(user: user) }
  scope :incomplete, ->() { where(completed_at: nil) }
  scope :completed, ->() { where.not(completed_at: nil) }

  def current_question_id
    self.ordered_question_ids[self.current_question_id_index]
  end

  def score(test_variable_id)
    test_attempt_responses.joins(:question, :question_response).
      where( Question.arel_table[:test_variable_id].eq(test_variable_id) ).
      pluck(QuestionResponse.arel_table[:points]).sum
  end

  private

  def set_attempt_params
    self.started_at ||= Time.now
    self.ordered_question_ids ||= self.test.question_ids
  end

end
