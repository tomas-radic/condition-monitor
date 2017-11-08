class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :label
      t.date :produced_at
      t.date :expiration_at
      t.integer :user_id

      t.timestamps
    end
  end
end
