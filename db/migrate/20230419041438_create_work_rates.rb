class CreateWorkRates < ActiveRecord::Migration[7.0]
  def change
    create_table :work_rates do |t|
      t.integer :impressed
      t.integer :comedy
      t.integer :love
      t.integer :excitement
      t.integer :deep
      t.integer :favorite_degree
      t.references :user, null: false,foreign_key: true
      t.references :work, null: false,foreign_key: true
      t.timestamps
    end
  end
end
