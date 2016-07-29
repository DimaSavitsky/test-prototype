class CreateJobPostings < ActiveRecord::Migration[5.0]
  def change
    create_table :job_postings do |t|
      t.string :onetsoc_code

      t.references :user

      t.boolean :abilities, array: true
      t.boolean :tasks, array: true
    end
  end
end
