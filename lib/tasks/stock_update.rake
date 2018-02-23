desc 'Update the stock price'
task :update_stock_price => :environment do 
  Stock.iex_api
  Stock.iex_api_dividend
end
