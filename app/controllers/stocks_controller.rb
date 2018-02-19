class StocksController < ApplicationController
  
  attr_accessor :m, :news
  before_action :find_stock, :only => [:show, :edit, :update, :delete, :destroy]
  before_action :find_date, :only => [:new]
  before_action :set_month, :only => [:show]

  def index
    unless Stock.last.nil? && Account.last.nil?
      @stocks = @account.stocks.sorted
    end
  end

  def show
    Stock.iex_api
    Stock.iex_api_dividend
  end

  def new
    @stock = Stock.new
  end

  def create
    @stock = Stock.new(stock_params)
    if @stock.save
      flash[:notice] = "Congratulations! You have just added #{@stock.ticker}"
      redirect_to(pages_path)
    else
      render('new')
    end
  end

  def edit
  end

  def update
    if @stock.update_attributes(stock_params)
      flash[:notice] = "You have successfully updated #{@stock.ticker}"
      redirect_to(pages_path)
    else
      render('edit')
    end
  end

  def delete
  end

  def destroy
    @stock.destroy
    flash[:notice] = "See ya."
    redirect_to(pages_path)
  end

  def import
    Stock.import(params[:file])
    redirect_to pages_path, notice: "Data successfully imported!"
  end

  private

  def find_stock
    @stock = Stock.find(params[:id])
  end

  def find_date
    @date = Date.today
    @date = @date.strftime("%B")
  end

  def stock_params
     params.require(:stock).permit(:ticker, :dividend_yield, :shares,
                                   :dividend_type, :ex_date, :income,
                                   :company_details, :company_name, :eps,
                                   :stock_price, :pe, :market_cap, :enterprise_value,
                                   :account_id)
  end

  def search_params
    params.require(:ticker).permit(:stock, :account_id)
  end

  def set_month
    @stocks = Stock.all
    @accounts = Account.all
    @date = Date.today
    @date = @date.strftime("%B")
    month = @date.downcase


    @m = "#{month}_income"
  end

  def get_news
    @stock = Stock.find(params[:id])
   # @news = Stock.grab_news
  end

end
