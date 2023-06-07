class AddColumnToWorkRates < ActiveRecord::Migration[7.0]
  def change
    add_column :work_rates, :total, :float
  end
end
