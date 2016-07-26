class AssociateTestResultsWithAbilities < ActiveRecord::Migration[5.0]

  def change
    remove_column :test_results, :attribute_name, :string

    add_column :test_results, :internal_ability_id, :integer
  end

end
