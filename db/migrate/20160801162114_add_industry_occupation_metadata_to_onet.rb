class AddIndustryOccupationMetadataToOnet < ActiveRecord::Migration[5.0]

  class InternalIndustry < ActiveRecord::Base
  end

  class Metadata < ActiveRecord::Base
    self.table_name = :occupation_level_metadata
  end

  def up
    suppress_messages do
      execute(File.open('vendor/sql/07_occupation_level_metadata.sql').read)
    end
    create_table :internal_industries do |t|
      t.string :industry_name
      t.string :metadata_response
    end

    Metadata.all.pluck(:response).uniq.each do |industry|
      InternalIndustry.create(
        metadata_response: industry,
        industry_name: industry.split('(').first.rstrip
      )
    end
  end

  def down
    drop_table :internal_industries
    drop_table :occupation_level_metadata
  end
end
