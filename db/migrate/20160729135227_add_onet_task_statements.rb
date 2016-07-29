class AddOnetTaskStatements < ActiveRecord::Migration[5.0]
  def up
    suppress_messages do
      execute(File.open('vendor/sql/17_task_statements.sql').read)
    end
  end

  def down
    drop_table :task_statements
  end
end
