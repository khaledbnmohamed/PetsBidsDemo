require 'rails_helper'

RSpec.describe CalculateAuctionResultsService, type: :service do
  describe '#Calculate auction result' do
    let(:pet) { FactoryBot.create(:pet, count: 10, price: 5) }
    it 'set the second auction for the winning correctly' do
      FactoryBot.create_list(:bid, 15, pet: pet)
      winning_bid = FactoryBot.create(:bid, pet: pet, bid_price: 200_000)
      second_winning = FactoryBot.create(:bid, pet: pet, bid_price: 500)
      described_class.call(pet)
      expect(winning_bid.reload.paid_price).to eq second_winning.bid_price
    end

    it 'break the tie alphabetically' do
      pet = FactoryBot.create(:pet, count: 1, price: 5)
      user_a = FactoryBot.create(:user, name: 'aaaa')
      user_b = FactoryBot.create(:user, name: 'bbb')
      second_winning = FactoryBot.create(:bid, pet: pet, bid_price: 15, user: user_b)
      winning_bid = FactoryBot.create(:bid, pet: pet, bid_price: 15, user: user_a)
      described_class.call(pet)

      expect(winning_bid.reload.paid_price).to eq second_winning.bid_price
      expect(second_winning.reload.paid_price).to eq nil
    end

    it 'return no winner if no bids' do
      pet = FactoryBot.create(:pet, count: 10, price: 5)
      result_array = described_class.call(pet)
      expect(result_array[:error]).to eq 'No Winners'
    end
  end
end
