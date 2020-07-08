class UserStocksController < ApplicationController
  
  def create
    stock = Stock.check_db(params[:ticker]) #Checks if stcok exists in Stock DB
    if stock.blank? #If stock is not in DB create
      stock = Stock.new_lookup(params[:ticker])
      stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Stock #{stock.name} was successfully added to your portfolio"
    redirect_to my_portfolio_path
  end
end
