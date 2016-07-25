class AddOnetAbilities < ActiveRecord::Migration[5.0]
  def up
    suppress_messages do
      execute(File.open('vendor/sql/01_content_model_reference.sql').read)
      execute(File.open('vendor/sql/11_abilities.sql').read)
    end
  end

  def down
    drop_table :abilities
    drop_table :content_model_reference
  end
end
