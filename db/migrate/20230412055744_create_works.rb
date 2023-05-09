class CreateWorks < ActiveRecord::Migration[7.0]
  def change
    create_table :works do |t|
      t.string :title
      t.string :release
      t.integer :episode_count
      t.string :media
      t.string :image
      t.integer :annict_id, null: false, foreign_key: true
      t.timestamps
    end
    add_index :works, :title, unique: true
    add_index :works, :release, unique: true
    add_index :works, :annict_id, unique: true
  end
end
