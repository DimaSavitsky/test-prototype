class AddIndustryToJobPosting < ActiveRecord::Migration[5.0]
  def change
    add_column :job_postings, :internal_industry_id, :integer, default: nil
  end
end
