class PagesController < ApplicationController
  attr_accessor :income, :monthly_income

 # before_action :require_login
  before_action :set_income, :only => [:index]
  before_action :monthly_income, :only => [:index]

  def index
    @stocks = Stock.all
    @date = Date.today
    @date = @date.strftime("%B")
     if params[:search]
      @stocks = Stock.where( 'ticker LIKE ?', "%#{params[:search]}")
      @stock = Stock.search(params[:search])
     else
      @stocks = Stock.all
     end
  end

  def display_results
    if params[:search]
      @stocks = Stock.where( 'ticker LIKE ?', "%#{params[:search]}")
      @stock = Stock.search(params[:search])
    else
      @stocks = Stock.all
    end
  end

  private 

  def set_income
    @stocks = Stock.all
    @income = 0

    @stocks.each do |stock|
      stock.yearly_income = 0
      @income += stock.yearly_income
    end
  end

  def monthly_income
    @stocks = Stock.all
    @date = Date.today
    month = @date.strftime("%B").downcase

    @monthly_income = 0

    m = "#{month}_income"

    @stocks.each do |stock|
      @monthly_income += stock.send(m)
    end
  end
end
