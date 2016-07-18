class AddPublichedAndTimeLimitToTests < ActiveRecord::Migration[5.0]
  def change
    add_column :tests, :time_limit, :integer
    add_column :tests, :published, :boolean, default: false
    add_column :tests, :randomized, :boolean, default: false
  end
end
