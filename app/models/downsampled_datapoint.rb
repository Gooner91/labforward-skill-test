class DownsampledDatapoint < ApplicationRecord
  belongs_to :channel

  enum intervals: ['5m', '10m', '15m']
end
