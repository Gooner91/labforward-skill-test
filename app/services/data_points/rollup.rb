# frozen_string_literal: true

module DataPoints
  class Rollup
    #
    # initialize
    # @params {Integer} interval
    # can be used to provide a different interval
    #
    def initialize(interval = nil)
      @interval = interval || 5
      @time_lower_bound = set_time_lower_bound
    end

    def call
      downsampled_data = []
      last_data_point_log_time = DataPoint.last.created_at
      return if last_data_point_log_time < @time_lower_bound

      while last_data_point_log_time > @time_lower_bound
        channel_wise_average = DataPoint.where(created_at: @time_lower_bound..time_upper_bound)
                                        .group(:channel_id)
                                        .average(:value)
        channel_wise_average.each do |channel_id, average|
          downsampled_data << { channel_id: channel_id,
                                value: average.to_f,
                                time_interval: time_upper_bound,
                                created_at: Time.now.utc,
                                updated_at: Time.now.utc, }
        end

        @time_lower_bound += interval_in_minutes
      end
      DownsampledDatapoint.insert_all!(downsampled_data)
    end

    private

    #
    # set_time_lower_bound
    #
    def set_time_lower_bound
      if DownsampledDatapoint.blank?
        DataPoint.first.created_at.floor_to(interval_in_minutes)
      else
        last_logged_time = DownsampledDatapoint.last.time_interval
        last_logged_time + interval_in_minutes
      end
    end

    #
    # time_upper_bound
    #
    def time_upper_bound
      @time_lower_bound + interval_in_minutes
    end

    #
    # interval_in_minutes
    #
    def interval_in_minutes
      @interval.minutes
    end
  end
end
