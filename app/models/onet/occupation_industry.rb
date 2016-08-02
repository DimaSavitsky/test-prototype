module Onet
  class OccupationIndustry < Base
    self.table_name = :occupation_level_metadata

    belongs_to :occupation, class_name: 'Onet::Occupation', foreign_key: :onetsoc_code
    belongs_to :internal_industry, class_name: 'InternalIndustry', foreign_key: :response, primary_key: :metadata_response

    default_scope { order(onetsoc_code: :asc) }

    scope :actual, ->() { where.not(percent: [nil, 0]) }

  end
end
