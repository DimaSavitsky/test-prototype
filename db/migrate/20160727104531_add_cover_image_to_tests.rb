class AddCoverImageToTests < ActiveRecord::Migration[5.0]
  def change
    add_column :tests, :image, :string
    add_column :questions, :image, :string
  end
end
