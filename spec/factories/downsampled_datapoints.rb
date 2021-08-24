# frozen_string_literal: true

FactoryBot.define do
  factory :downsampled_datapoint do
    interval { '5m' }
    time_interval { Time.current + 5.minutes }
  end
end
