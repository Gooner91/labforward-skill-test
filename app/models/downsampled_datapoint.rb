# frozen_string_literal: true

class DownsampledDatapoint < ApplicationRecord
  belongs_to :channel

  enum interval: { '5m' => 0, '10m' => 1, '15m' => 2 }
end
