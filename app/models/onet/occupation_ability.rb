module Onet
  class OccupationAbility < Base

    self.table_name = :abilities

    belongs_to :occupation, class_name: 'Onet::Occupation', foreign_key: :onetsoc_code

    belongs_to :internal_ability, class_name: 'InternalAbility', foreign_key: :element_id, primary_key: :onet_content_element_id
  end
end
