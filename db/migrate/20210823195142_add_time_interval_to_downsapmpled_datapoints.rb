class AddTimeIntervalToDownsapmpledDatapoints < ActiveRecord::Migration[6.1]
  def change
    add_column :downsampled_datapoints, :time_interval, :datetime, null: false, after: :value
  end
end
