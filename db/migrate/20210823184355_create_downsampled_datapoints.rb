class CreateDownsampledDatapoints < ActiveRecord::Migration[6.1]
  def change
    create_table :downsampled_datapoints do |t|
      t.references :channel
      t.integer :interval
      t.string :value

      t.timestamps
    end
  end
end
