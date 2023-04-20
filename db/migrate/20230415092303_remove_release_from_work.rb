class RemoveReleaseFromWork < ActiveRecord::Migration[7.0]
    def up
      def change
        remove_column :works, :release
        remove_index :works, column: :release, unique: true
      end
    end

    def down
      def change
        add_column :works, :release, :string
        add_index :works, :release, unique: true
      end
    end
end
