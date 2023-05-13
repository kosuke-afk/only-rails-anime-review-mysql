class CreateCasts < ActiveRecord::Migration[7.0]
  def change
    create_table :casts do |t|
      t.references :work, type: :bigint, null: false
      t.string :character
      t.string :cast

      t.timestamps
    end
    add_foreign_key :casts, :works, column: :work_id, primary_key: :annict_id
  end
end
