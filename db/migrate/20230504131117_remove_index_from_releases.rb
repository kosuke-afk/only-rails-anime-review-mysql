class RemoveIndexFromReleases < ActiveRecord::Migration[7.0]
  def up
    remove_index :releases, :season, unique: true
    remove_index :releases, :year, unique: true
  end
  def down
    add_index :releases, :season, unique: true
    add_index :releases, :season, unique: true
  end
end
