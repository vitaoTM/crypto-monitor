require 'net/http'
require 'json'

class HomeController < ApplicationController
  # USD-BRL,EUR-BRL,BTC-BRL

  CURRENCIES = [
    { code: 'USD-BRL' },
    { code: "BTC-BRL" },
    { code: "EUR-BRL" }
]


  def index
    @chart_data = []

    CURRENCIES.each do |currency|
      url = URI("https://economia.awesomeapi.com.br/json/daily/#{currency[:code]}/15")

      response = Net::HTTP.get(url)
      # response = Net::HTTP.get(URI("https://economia.awesomeapi.com.br/json/daily/BTC-BRL/30"))
      data = JSON.parse(response)

      hash = {}
      data.each do |e|
        date = Time.at(e['timestamp'].to_i).strftime("%d/%m/%C")
        rate = e['high']
        hash[date] = rate
      end

      @chart_data << { name: currency[:code], data: hash }
      # aaa
    end
    # ppp

  end
end
