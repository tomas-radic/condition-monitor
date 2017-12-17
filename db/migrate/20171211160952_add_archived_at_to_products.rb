class AddArchivedAtToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :archived_at, :datetime
  end
end
