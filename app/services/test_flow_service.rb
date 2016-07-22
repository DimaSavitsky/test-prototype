class TestFlowService

  def test_attempt_id
    test_attempt.id
  end

  def current_question
    @current_question ||= test.questions.includes(:question_responses).find_by( id: current_question_id )
  end

  def answered_question_ids
    @answered_question_ids ||= test_attempt.test_attempt_responses.pluck(:question_id)
  end

  def current_response
    @current_response ||= test_attempt.test_attempt_responses.find_or_initialize_by(question_id: current_question_id)
  end

  def update_response(variant_id)
    current_response.update(question_response_id: variant_id, submitted_at: timestamp)
  end

  def goto(question_index)
    test_attempt.update(current_question_id_index: question_index)
  end

  def previous_question_index
    test_attempt.current_question_id_index - 1
  end

  def next_question_index
    test_attempt.current_question_id_index + 1
  end

  def on_question?(question_index)
    test_attempt.current_question_id_index == question_index
  end

  def finalize
    test_attempt.update(completed_at: timestamp)
  end

  private

  attr_reader :test, :user, :test_attempt, :timestamp

  def initialize( test: , user:)
    @user = user
    @test = test

    @timestamp = DateTime.now

    raise unless (@test && @user)

    @test_attempt = test.test_attempts.for_user(@user).incomplete.first_or_create(started_at: timestamp)
  end

  delegate :current_question_id, :ordered_question_ids, to: :test_attempt

end
