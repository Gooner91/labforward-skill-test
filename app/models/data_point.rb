# frozen_string_literal: true

class DataPoint < ApplicationRecord
  belongs_to :channel

  attr_accessor :skip_broadcast

  after_commit :broadcast, unless: Proc.new{ |data_point| data_point.skip_broadcast }

  private

  def broadcast
    ActionCable.server.broadcast 'DataPoint', as_json
  end
end
