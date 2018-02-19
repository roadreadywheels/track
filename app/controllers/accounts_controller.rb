class AccountsController < ApplicationController

  attr_accessor :sum, :m

  # before_action :require_login
  before_action :set_month, :only => [:index, :show]
  before_action :set_date, :only => [:index, :show]  

  def index
    @accounts = Account.all
    @stocks = Stock.all
    @sum = 0
    Account.monthly_income
  end

  def show 
    @account = Account.find(params[:id]) 
    @stocks = Account.find(params[:id]).stocks
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      flash[:notice] = "Congratulations you have just added #{@account.account_name}."
      redirect_to(root_path)
    else
      render ('new')
    end
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    if @account.update_attributes(account_params)
      flash[:notice] = "Nicely done!"
      redirect_to(account_path)
    else
      render('edit')
    end
  end

  def delete
    @account = Account.find(params[:id])
  end

  def destroy
    @account = Account.find(params[:id])
    @account.stocks.destroy_all
    @account.destroy
    flash[:notice] = "You have successfully deleted #{@account.account_name}"
    redirect_to(root_path)
  end

  private

  def account_params
    params.require(:account).permit(:account_name, :account_value, :january_income, :february_income,
                                    :march_income, :april_income, :may_income, :june_income, :july_income,
                                    :august_income, :septermber_income, :october_income, :november_income,
                                    :december_income)
  end

  def set_month
    @stocks = Stock.all
    @accounts = Account.all
    @date = Date.today
    month = @date.strftime("%B").downcase


    @m = "#{month}_income"
  end

  def set_date
    @date = Date.today
    @date = @date.strftime("%B")
  end


end
