class CreateReleases < ActiveRecord::Migration[7.0]
  def change
    create_table :releases do |t|
      t.integer :year
      t.string :season

      t.timestamps
    end
    add_index :releases, :year, unique: true
    add_index :releases, :season, unique: true
  end
end
