#describe CurrencyConverter do
  describe 'convert currency' do
    it 'gets a response from an api' do
      VCR.use_cassette 'model/currency_api_response' do
        converter = CurrencyConverter.new('USD', 'SEK')
        response = converter.convert
        response == 9.03413
      end
    end
  end
#end