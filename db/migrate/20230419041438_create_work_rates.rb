class CreateWorkRates < ActiveRecord::Migration[7.0]
  def change
    create_table :work_rates do |t|
      t.integer :impressed
      t.integer :comedy
      t.integer :love
      t.integer :excitement
      t.integer :deep
      t.integer :favorite_degree
      t.references :user, null: false, foreign_key: true
      t.references :work, type: :bigint, null: false

      t.timestamps
    end
    add_foreign_key :work_rates, :works, column: :work_id , primary_key: :annict_id
  end
end
