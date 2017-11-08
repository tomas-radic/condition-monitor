class CreateMeasurements < ActiveRecord::Migration[5.0]
  def change
    create_table :measurements do |t|
      t.datetime :measured_at
      t.integer :temperature
      t.integer :humidity
      t.integer :user_id

      t.timestamps
    end
  end
end
