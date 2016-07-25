module Onet
  class Occupation < Base

    self.table_name = :occupation_data
    self.primary_key = :onetsoc_code

    has_many :occupation_abilities, inverse_of: :occupation, foreign_key: self.primary_key

  end
end
