class InternalIndustry < ApplicationRecord

   has_many :occupation_industries, -> { actual },
            class_name: 'Onet::OccupationIndustry',
            foreign_key: :response,
            primary_key: :metadata_response
   has_many :occupations, through: :occupation_industries

end
