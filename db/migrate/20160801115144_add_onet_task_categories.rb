class AddOnetTaskCategories < ActiveRecord::Migration[5.0]
  def up
    suppress_messages do
      execute(File.open('vendor/sql/09_task_categories.sql').read)
      execute(File.open('vendor/sql/18_task_ratings.sql').read)
    end
  end

  def down
    drop_table :task_ratings
    drop_table :task_categories
  end
end
