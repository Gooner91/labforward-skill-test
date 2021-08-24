# frozen_string_literal: true

FactoryBot.define do
  factory :downsampled_datapoint do
    interval do '5m' end
    time_interval { Time.current + 5.minutes }
  end
end
