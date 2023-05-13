class ChangeTitleColumnAtTypeInEpisodesTable < ActiveRecord::Migration[7.0]
  def up
    change_column :episodes, :title, :text
  end

  def down
    change_column :episodes, :title, :string
  end
end
