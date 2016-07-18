class AddResultsToTests < ActiveRecord::Migration[5.0]

  def change
    create_table :test_results do |t|
      t.references :test_variable
      t.string :attribute_name
    end

    create_table :test_result_ranges do |t|
      t.references :test_result
      t.integer :range_start
      t.integer :range_stop
      t.text :result_message
      t.decimal :attribute_score, precision: 4, scale: 2
    end
  end

end
