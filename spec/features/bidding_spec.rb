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

  it "vlidates smaller bids" do

    currency = FactoryBot.create(:currency, code: "SEK")
    item = FactoryBot.create(:item, start_price: 100, currency: currency)

    log_in(item.user)
    visit item_path(item)


    fill_in "bid_value", with: 99
    click_button "Make a bid"

    expect(page).to have_content('Your bid is smaller than biggest bid or start price')
    expect(item.bids.count).to eq(0)
  end

  it "show converts items currency to users currency" do
    first_currency = FactoryBot.create(:currency, code: "SEK")
    item = FactoryBot.create(:item, start_price: 100, currency: first_currency)

    log_in(item.user)

    page.driver.browser.set_cookie("currency_id=1")
    visit item_path(item)
    fill_in "bid_value", with: 100
    click_button "Make a bid"
    puts item.bids.first.bid
    expect(item.bids.first.bid).not_to eq(100)
    expect(page).to have_content('100USD')
  end

  private

  def log_in(user)
    visit root_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end
end
