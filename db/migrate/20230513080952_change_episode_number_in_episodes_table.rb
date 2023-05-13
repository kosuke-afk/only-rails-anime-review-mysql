class ChangeEpisodeNumberInEpisodesTable < ActiveRecord::Migration[7.0]
  def up
    change_column :episodes, :episode_number, :string
  end
  def down
    change_column :episodes, :episode_number, :integer
  end
end
