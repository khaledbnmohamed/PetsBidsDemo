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
FactoryBot.define do
  factory :pet do
    name { FFaker::AnimalUS.common_name }
    status { "in_sale" }
    notes { FFaker::Lorem.word }
    price { rand(1..10) }
    user
  end
end
