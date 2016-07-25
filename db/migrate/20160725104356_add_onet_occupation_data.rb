class AddOnetOccupationData < ActiveRecord::Migration[5.0]
  def up
    suppress_messages do
      execute(File.open('vendor/sql/03_occupation_data.sql').read)
    end
  end

  def down
    drop_table :occupation_data
  end
end
