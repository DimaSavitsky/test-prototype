class AddInternalUserAbility < ActiveRecord::Migration[5.0]

  class ContentModelReference < ActiveRecord::Base
    self.table_name = :content_model_reference

    scope :abilities, ->() { where(arel_table[:element_id].matches('1.A.1._._')) }   # limited to the abilities in 'Cognitive Abilities' category
  end

  class InternalAbility < ActiveRecord::Base
  end

  def change
    create_table :internal_abilities do |t|
      t.string :onet_content_element_id

      t.string :name, limit: 150
      t.string :description, limit: 1500
    end

    reversible do
      ContentModelReference.abilities.each do |ability_data|
        InternalAbility.create(
          onet_content_element_id:  ability_data.element_id,
          name:                     ability_data.element_name,
          description:              ability_data.description
        )
      end
    end

    create_table :user_internal_abilities do |t|
      t.references :internal_ability
      t.references :user

      t.decimal :level, precision: 3, scale: 2
    end
  end

end
