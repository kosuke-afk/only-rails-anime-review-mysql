class AddSortNumberToEpisode < ActiveRecord::Migration[7.0]
  def change
    add_column :episodes, :sort_number, :integer, null: false
  end
end
