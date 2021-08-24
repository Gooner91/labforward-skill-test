class AddDefaultIntervalValue < ActiveRecord::Migration[6.1]
  def change
    change_column_default :downsampled_datapoints, :interval, 0
  end
end
