class DropRollUpsTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :rollups
  end
end
