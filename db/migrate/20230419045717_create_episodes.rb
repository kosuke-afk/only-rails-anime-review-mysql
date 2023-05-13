class CreateEpisodes < ActiveRecord::Migration[7.0]
  def change
    create_table :episodes do |t|
      t.string :title
      t.integer :episode_number
      t.references :work, type: :bigint, null: false
      t.timestamps
    end
    add_foreign_key :episodes, :works, column: :work_id, primary_key: :annict_id
  end
end
