class RemoveReleaseFromWork < ActiveRecord::Migration[7.0]
    def up
      remove_column :works, :release, :string
    end
    def down
      add_column :works, :release, :string
      add_index :works, :release, unique: true
    end
end
