module CalculateAuctionResultsService
  def self.call(pet)
    return { result: nil, error: 'No Winners' } unless pet.bids.present?

    sorted_bids = pet.bids.order(bid_price: :desc, user_name: :asc)
    bids_result = calculate_paid_price(sorted_bids, pet.count)
    { result: bids_result, error: nil }
  end

  def self.calculate_paid_price(bids_array, pets_count)
    actual_paid_array = bids_array[1..pets_count]
    bids_second_auction = bids_array[0..actual_paid_array.size - 1]

    bids_second_auction.zip(actual_paid_array) { |b, a| b.update(paid_price: a.bid_price) }
    bids_second_auction
  end
end
