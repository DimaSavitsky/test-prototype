class CreateTestVariables < ActiveRecord::Migration[5.0]
  def change
    create_table :test_variables do |t|
      t.string :name
      t.references :test
    end
  end
end
