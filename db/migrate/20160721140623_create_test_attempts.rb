class CreateTestAttempts < ActiveRecord::Migration[5.0]

  def change
    create_table :test_attempts do |t|
      t.references :test
      t.references :user
      t.datetime :started_at
      t.datetime :completed_at

      t.integer :ordered_question_ids, array: true
      t.integer :current_question_id_index, default: 0
    end

    create_table :test_attempt_responses do |t|
      t.references :test_attempt
      t.references :question
      t.references :question_response
      t.datetime :submitted_at
    end

  end
end
