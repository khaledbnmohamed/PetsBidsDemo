# frozen_string_literal: true

module Api::V1
  class BidBlueprint < Blueprinter::Base
    fields :user_id, :pet_id, :bid_price, :order, :paid_price

  end
end
