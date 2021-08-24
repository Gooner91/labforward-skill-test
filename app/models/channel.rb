# frozen_string_literal: true

class Channel < ApplicationRecord
  belongs_to :device
  has_many :data_points, dependent: :destroy
  has_many :downsampled_datapoints, dependent: :destroy
end
