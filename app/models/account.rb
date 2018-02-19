class Account < ApplicationRecord

  has_many :stocks

  scope :sorted, lambda { order("stock.dividend_yield ASC") }


  def self.monthly_income
    @accounts = Account.all
    @stocks = Stock.all    
    @date = Date.today
    monthly_income = Hash.new 
    monthly_income = {:january_income => 0, :february_income => 0, :march_income => 0, :april_income => 0, :may_income => 0,
                :june_income => 0, :july_income => 0, :august_income => 0, :september_income => 0, :october_income => 0,
                :november_income => 0, :december_income => 0}
    count = 1

    unless Account.last.nil?
      until count > Account.last.id
        if Account.exists?(:id => count)
          account = @accounts.find(count)
          stock = @accounts.find(count).stocks
          stock.each do |s|
            monthly_income[:january_income]   += s.january_income
            monthly_income[:february_income]  += s.february_income
            monthly_income[:march_income]     += s.march_income
            monthly_income[:april_income]     += s.april_income
            monthly_income[:may_income]       += s.may_income
            monthly_income[:june_income]      += s.june_income
            monthly_income[:july_income]      += s.july_income
            monthly_income[:august_income]    += s.august_income
            monthly_income[:september_income] += s.septermber_income
            monthly_income[:october_income]   += s.october_income
            monthly_income[:november_income]  += s.novemeber_income
            monthly_income[:december_income]  += s.december_income
          end
          account.january_income = monthly_income[:january_income]
          account.february_income = monthly_income[:february_income]   
          account.march_income =  monthly_income[:march_income]     
          account.april_income =  monthly_income[:april_income]     
          account.may_income =  monthly_income[:may_income]       
          account.june_income =  monthly_income[:june_income]     
          account.july_income =  monthly_income[:july_income]      
          account.august_income =  monthly_income[:august_income]    
          account.septermber_income =  monthly_income[:september_income] 
          account.october_income =  monthly_income[:october_income]   
          account.novemeber_income =  monthly_income[:november_income]  
          account.december_income =  monthly_income[:december_income]  
          puts monthly_income.inspect 
          account.save
          monthly_income = {:january_income => 0, :february_income => 0, :march_income => 0, :april_income => 0, :may_income => 0,
                      :june_income => 0, :july_income => 0, :august_income => 0, :september_income => 0, :october_income => 0,
                      :november_income => 0, :december_income => 0}                  
          count += 1
        else
          count += 1
        end
      end
    end
  end

end
