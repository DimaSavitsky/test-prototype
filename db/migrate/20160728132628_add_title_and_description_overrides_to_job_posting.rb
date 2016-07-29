class AddTitleAndDescriptionOverridesToJobPosting < ActiveRecord::Migration[5.0]
  def change
    add_column :job_postings, :title, :string
    add_column :job_postings, :description, :text
  end
end
