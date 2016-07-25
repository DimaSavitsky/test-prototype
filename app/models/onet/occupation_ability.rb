module Onet
  class OccupationAbility < Base

    self.table_name = :abilities

    belongs_to :occupation, class_name: Onet::Occupation, foreign_key: :onetsoc_code

    scope :importance, ->() { where(scale_id: 'IM') }
    scope :level, ->() { where(scale_id: 'LV') }

    scope :relevant, ->() { where.not(not_relevant: 'Y').or(where(not_relevant: nil)) }
  end
end
