class CreateResponsesForQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :question_responses do |t|
      t.references :question
      t.string :text
      t.integer :points, default: 0
    end
  end
end
