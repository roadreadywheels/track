require 'quandl'
require 'httparty'

class Stock < ApplicationRecord
  require 'csv'
  include HTTParty

  belongs_to :account
  has_many :news

  scope :sorted, lambda { order("dividend_yield ASC") }

  ### Import File ###

  def self.import(file)
    if file 
      CSV.foreach(file.path, :headers => true) do |row|
        Stock.create! row.to_hash
      end
    end
  end

  ### Search Field ###

  def self.saved_stocks
    @stocks = Stock.all
    stock_tickers = []
    @stocks.each do |stock|
      stock_tickers << stock
    end
    return stock_tickers
  end

  def self.search(searh="")
    if search 
      s = Stock.saved_stocks
      found = s.select do |stock|
        stock.ticker.downcase == (search.downcase)
        # stock.company_name.downcase == (search.downcase)
      end
    else
      found = "No results match..."
    end
    found = found.shift
  end

  ### Stock Data Gathering ###
  
  def self.iex_api
    @stocks = Stock.all

    @stocks.each do |stock|
      data = HTTParty.get("https://api.iextrading.com/1.0/stock/#{stock.ticker}/quote")
      s = Stock.where(:ticker => "#{stock.ticker}").first
      s.update_attributes(:market_cap => data['marketCap'], :stock_price => data['close']) 
    end
  end

  def self.iex_api_dividend
    @stocks = Stock.all
    dividend_yield = Hash.new{}
    dividend_yield = {:count => 0, :div_yield => 0}
    payments = Hash.new{}
    payments = {:january_income => 0, :february_income => 0, :march_income => 0, :april_income => 0, :may_income => 0,
                :june_income => 0, :july_income => 0, :august_income => 0, :september_income => 0, :october_income => 0,
                :november_income => 0, :december_income => 0}
    f       = 0
    count   = 0
    payment = 0
    ### Dividend Variables ###
    month   = []
    m       = ""

    ### Grab Div Frequency ###
    @stocks.each do |stock|
      f = 0
      data      = HTTParty.get("https://api.iextrading.com/1.0/stock/#{stock.ticker}/quote")
      frequency = HTTParty.get("https://api.iextrading.com/1.0/stock/#{stock.ticker}/dividends/2y")
      ### Changed to 6-months for HSBC test ###
      dividends = HTTParty.get("https://api.iextrading.com/1.0/stock/#{stock.ticker}/dividends/6m")
      company_details = HTTParty.get("https://api.iextrading.com/1.0/stock/#{stock.ticker}/company")


      ### Delete Duplicate Months ###
      dividends.each do |x|
        unless x.nil? 
          m = DateTime.parse(x['paymentDate']).to_date.strftime("%B").to_s
          if month.include?(m)
            next
          else
            month << m
          end
        else
          next
        end
      end

      frequency.each do |freq|
        freq 
        f += 1
        if f == 4  
          dividend_yield[:count] = f
        end
      end

      puts stock.ticker

      frequency.each do |pay|
        payment = pay['amount']
        pay = pay['paymentDate']
        pay = DateTime.parse(pay).to_date.strftime("%B").to_s
        case pay
        when 'January'
          payments[:january_income]   = payment
        when 'February'
          payments[:february_income]  = payment
        when 'March'
          payments[:march_income]     = payment
        when 'April' 
          payments[:april_income]     = payment
        when 'May'
          payments[:may_income]       = payment
        when 'June'
          payments[:june_income]      = payment
        when 'July'
          payments[:july_income]      = payment
        when 'August'
          payments[:august_income]    = payment
        when 'September'
          payments[:september_income] = payment
        when 'October'
          payments[:october_income]   = payment
        when 'November'
          payments[:november_income]  = payment
        when 'December'
          payments[:december_income]  = payment
        end

        count += 1
        if count == 4
          count = 0
          break 
        end
      end

      dividends.each do |div|
        dividend_yield[:div_yield] = div['amount']
      end

      case dividend_yield[:count]
      when 1
        dividend_yield[:div_yield] = (dividend_yield[:div_yield] * 1)
        stock.dividend_type = "Annual"
      when 2
        dividend_yield[:div_yield] = (dividend_yield[:div_yield] * 2)
        stock.dividend_type = "Semi-Annual"
      when 4
        dividend_yield[:div_yield] = (dividend_yield[:div_yield] * 4)
        stock.dividend_type = "Quarterly"
      end


      stock.dividend_yield = (dividend_yield[:div_yield]/data['previousClose'])
      stock.declared_amount = dividend_yield[:div_yield]
      stock.yearly_income = (stock.shares * stock.declared_amount)


            #### Build Out Payout Per Month ####
      stock.january_income    = (payments[:january_income]   * stock.shares)
      stock.february_income   = (payments[:february_income]  * stock.shares)
      stock.march_income      = (payments[:march_income]     * stock.shares)
      stock.april_income      = (payments[:april_income]     * stock.shares)
      stock.may_income        = (payments[:may_income]       * stock.shares)
      stock.june_income       = (payments[:june_income]      * stock.shares)
      stock.july_income       = (payments[:july_income]      * stock.shares)
      stock.august_income     = (payments[:august_income]    * stock.shares)
      stock.septermber_income = (payments[:september_income] * stock.shares)
      stock.october_income    = (payments[:october_income]   * stock.shares)
      stock.novemeber_income  = (payments[:november_income]  * stock.shares)
      stock.december_income   = (payments[:december_income]  * stock.shares)

      if f == 0
        stock.dividend_type      = "N/A"
        stock.dividend_yield     = 0
        stock.yearly_income      = 0
        stock.january_income     = 0
        stock.february_income    = 0
        stock.march_income       = 0
        stock.april_income       = 0
        stock.may_income         = 0
        stock.june_income        = 0
        stock.july_income        = 0
        stock.august_income      = 0
        stock.septermber_income  = 0
        stock.october_income     = 0
        stock.novemeber_income   = 0
        stock.december_income    = 0
      end

      puts payments.inspect
      stock.company_name = company_details['companyName']
      puts stock.company_name
      stock.save
      payments = {:january_income => 0, :february_income => 0, :march_income => 0, :april_income => 0, :may_income => 0,
                :june_income => 0, :july_income => 0, :august_income => 0, :september_income => 0, :october_income => 0,
                :november_income => 0, :december_income => 0}      
    end
  end
end
