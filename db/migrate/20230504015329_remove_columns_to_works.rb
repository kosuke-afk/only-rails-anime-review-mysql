class RemoveColumnsToWorks < ActiveRecord::Migration[7.0]
    def up 
      remove_column :works, :year, type: :integer
      remove_column :works, :season, type: :string
    end
    def down
      add_column :works, :year, :integer
      add_column :works, :season, :string
    end
end
