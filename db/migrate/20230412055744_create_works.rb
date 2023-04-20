class CreateWorks < ActiveRecord::Migration[7.0]
  def change
    create_table :works, id: false do |t|
      t.string :title
      t.string :release
      t.integer :episode_count
      t.string :media
      t.string :image
      t.integer :annict_id, null: false, primary_key: true
      t.timestamps
    end
    add_index :works, :title, unique: true
    add_index :works, :release, unique: true
  end
end
