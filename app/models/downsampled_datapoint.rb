# frozen_string_literal: true

class DownsampledDatapoint < ApplicationRecord
  belongs_to :channel

  enum interval: %w[5m 10m 15m]
end
