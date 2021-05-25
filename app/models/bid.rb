# frozen_string_literal: true

# == Schema Information
#
# Table name: bids
#
#  id         :integer          not null, primary key
#  bid_price  :float
#  order      :integer          default(0)
#  paid_price :float
#  user_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  pet_id     :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_bids_on_pet_id   (pet_id)
#  index_bids_on_user_id  (user_id)
#
class Bid < ApplicationRecord
  belongs_to :pet, inverse_of: :bids
  belongs_to :user, inverse_of: :bids

  before_save :set_user_name

  def set_user_name
    self.user_name = user.name
  end
end
