class AddAveragedAtToMeasurements < ActiveRecord::Migration[5.0]
  def change
    add_column :measurements, :averaged_at, :datetime
  end
end
