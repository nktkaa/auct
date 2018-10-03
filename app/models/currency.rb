class Currency < ApplicationRecord
  has_many :users
  has_many :items

  enum code: [ :SEK, :USD, :GBP, :EUR]
end