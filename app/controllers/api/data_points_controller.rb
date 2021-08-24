# frozen_string_literal: true

module Api
  class DataPointsController < Api::BaseController
    def index
      data_points = filtered(DataPoint)

      respond_with data_points
    end

    def down_sampled
      down_sampled_data = DownsampledDatapoint.paginate(page: params[:page],
                                                        per_page: 20)
      
      render json: DataPoints::DownSampledDataSerializer
                     .new(down_sampled_data)
                     .serializable_hash
    end

  end
end
