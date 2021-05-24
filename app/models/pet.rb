# frozen_string_literal: true

# == Schema Information
#
# Table name: pets
#
#  id         :integer          not null, primary key
#  count      :integer          default(1)
#  name       :string
#  notes      :string
#  price      :float
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_pets_on_user_id  (user_id)
#
class Pet < ApplicationRecord

  belongs_to :user, inverse_of: :pets
  has_many :bids, class_name: "Bid", foreign_key: "pet_id", dependent: :restrict_with_exception, inverse_of: :pet


  def finish_auction

  end
end
