class Item < ApplicationRecord
  belongs_to :user
  belongs_to :currency
  has_many :bids

  def highest_bid
    bid = self.bids.order(bid: :desc).first&.bid || self.start_price
    bid.to_i
  end

end
