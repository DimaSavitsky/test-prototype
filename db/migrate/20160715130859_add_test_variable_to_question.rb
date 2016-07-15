class AddTestVariableToQuestion < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :test_variable_id, :integer
    remove_column :questions, :test_id
  end
end
