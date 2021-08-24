# Can be executed using rails db:seed VERSION=001_sample_data_points.rb

# Adding dummy data_points (10 per device via channel) for different devices
# Each data_point for now is given a random float value

Device.all.each do |device|
  channel = device.channels.sample
  minute_index = 0
  10000.times do
    minute_index += 1
    DataPoint.create(channel: channel,
                     value: rand(1.0..999.9),
                     skip_broadcast: true,
                     created_at: Time.now + minute_index.minutes)
  end
end

