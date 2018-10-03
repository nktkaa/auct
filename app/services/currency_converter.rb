require 'net/http'
require 'json'

class CurrencyConverter

  def initialize(first, second)
    @formula = "#{first}_#{second}"
  end

  def convert
    response = Net::HTTP.get_response(convert_query)
    response.is_a?(Net::HTTPSuccess) ? JSON.parse(response.body)[@formula] : 1
  end

  def convert_query
    path = '/api/v6/convert'
    uri = URI(ENV['CURRENCY_CONVERTER_ORIGIN'] + path)
    params = { q: @formula, compact: 'ultra' }
    uri.query = URI.encode_www_form(params)
    uri
  end

end