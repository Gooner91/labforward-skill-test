# frozen_string_literal: true

class DataPoints::DownSampledDataSerializer
  include JSONAPI::Serializer
  attributes :value, :time_interval, :interval, :channel_id
end
