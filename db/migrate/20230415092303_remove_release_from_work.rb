class RemoveReleaseFromWork < ActiveRecord::Migration[7.0]
  def change
      remove_column :works, :release
  end
end
