class AddColumnToWorks < ActiveRecord::Migration[7.0]
  def change
    add_column :works, :title_kana, :string
  end
end
