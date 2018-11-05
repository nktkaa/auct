class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :item

  def self.convert_currency(user_currency, item_currency, amount)
    CurrencyConverter.new(user_currency, item_currency).convert*amount
  end

end
