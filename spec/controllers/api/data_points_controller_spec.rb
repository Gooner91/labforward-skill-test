# frozen_string_literal: true

require 'rails_helper'

describe Api::DataPointsController, type: :controller do
  let(:device) { create(:device) }
  let(:channel) { create(:channel, device: device) }
  let!(:down_sampled_data) do
    create_list(:downsampled_datapoint, 100,
                channel: channel,
                value: rand(1.0..999.9))
  end

  describe 'GET /api/data_points' do
    before do
      5.times do |index|
        travel_to index.hours.from_now do
          create :data_point
        end
      end
    end

    it 'returns all data_points' do
      get :index, format: :json

      expect(response).to have_http_status(:ok)
      expect(response.body).to have_json_size(5)
    end

    it 'can be filtered by time range' do
      get :index, format: :json, params: { filter: { created_at: { gt: 30.minutes.from_now, lt: 3.5.hours.from_now } } }

      expect(response).to have_http_status(:ok)
      expect(response.body).to have_json_size(3)
    end
  end

  describe 'GET /api/down_sampled' do
    it 'returns 20 down_sampled records per page' do
      get :down_sampled, format: :json, params: { page: 1 }
      parsed_response = JSON.parse(response.body)['data']
      expect(parsed_response.size).to eq(20)
    end

    it 'returns appropriate attributes' do
      get :down_sampled, format: :json, params: { page: 1 }
      parsed_response = JSON.parse(response.body)['data']
      expect(parsed_response.first['attributes'].keys)
        .to eq(%w[value time_interval interval channel_id])
    end
  end
end
