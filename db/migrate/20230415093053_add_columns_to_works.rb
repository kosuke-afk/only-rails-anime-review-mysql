class AddColumnsToWorks < ActiveRecord::Migration[7.0]
  def change
    add_column :works, :year, :integer
    add_column :works, :season, :string
  end
end
