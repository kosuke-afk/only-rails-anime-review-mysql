class ChangeColumnToWorkRates < ActiveRecord::Migration[7.0]
  def up
    change_column :work_rates, :impressed, :float
    change_column :work_rates, :comedy, :float
    change_column :work_rates, :love, :float
    change_column :work_rates, :excitement, :float
    change_column :work_rates, :deep, :float
  end

  def down
    change_column :work_rates, :impressed, :integer
    change_column :work_rates, :comedy, :integer
    change_column :work_rates, :love, :integer
    change_column :work_rates, :excitement, :integer
    change_column :work_rates, :deep, :integer
  end
end
