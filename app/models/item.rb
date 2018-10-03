class Item < ApplicationRecord
  belongs_to :user
  belongs_to :currency
  has_many :bids
end
