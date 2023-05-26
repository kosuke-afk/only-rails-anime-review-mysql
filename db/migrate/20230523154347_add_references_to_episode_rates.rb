class AddReferencesToEpisodeRates < ActiveRecord::Migration[7.0]
  def change
    add_reference :episode_rates, :work, type: :bigint, null: false
    add_foreign_key :episode_rates, :works, column: :work_id, primary_key: :annict_id
  end
end
