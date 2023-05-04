class AddReferenceToWorks < ActiveRecord::Migration[7.0]
  def change
    add_reference :works, :release, null: false, foreign_key: true
  end
end
