every :day, at: '9:40pm' do 
  rake 'data_refresh:update_stock_price', :environment => 'production'
end