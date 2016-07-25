module Onet
  class OccupationAbility < Base

    self.table_name = :abilities

    belongs_to :occupation, class_name: Onet::Occupation, foreign_key: :onetsoc_code

  end
end
