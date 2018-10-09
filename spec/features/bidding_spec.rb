require "rails_helper"

describe "Bidding" do
  it "works" do
    currency = FactoryBot.create(:currency, code: "SEK")
    item = FactoryBot.create(:item, start_price: 100, currency: currency)

    log_in(item.user)
    visit item_path(item)

    expect(page).to have_content(item.name)

    fill_in "bid_value", with: 101
    click_button "Make a bid"

    expect(item.bids.count).to eq(1)
  end

  private

  def log_in(user)
    visit root_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end
end
