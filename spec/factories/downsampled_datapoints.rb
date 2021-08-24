FactoryBot.define do
  factory :downsampled_datapoint do
    interval { '5m' }
    time_interval { Time.now + 5.minutes }
    
  end
end
