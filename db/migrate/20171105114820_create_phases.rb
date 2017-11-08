class CreatePhases < ActiveRecord::Migration[5.0]
  def change
    create_table :phases do |t|
      t.string :name
      t.datetime :begin_at
      t.datetime :end_at
      t.datetime :planned_end_at
      t.integer :product_id

      t.timestamps
    end
  end
end
