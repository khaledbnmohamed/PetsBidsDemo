# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  email          :string           not null
#  mobile         :string           not null
#  name           :string           not null
#  password_diget :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class User < ApplicationRecord
  has_many :pets, class_name: "Pet", foreign_key: "user_id", dependent: :restrict_with_exception, inverse_of: :user
  has_many :bids, class_name: "Bid", foreign_key: "user_id", dependent: :restrict_with_exception, inverse_of: :user

end
