require 'rails_helper'

RSpec.describe ItemsController, type: :controller do

  describe "GET #index" do
    it "don`t access without registration" do
      get :index
      expect(response.body).to eq('<html><body>You are being <a href="http://test.host/users/sign_in">redirected</a>.</body></html>')
    end
  end

end