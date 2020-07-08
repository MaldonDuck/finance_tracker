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
  
  def destroy
    stock = Stock.find(params[:id])
    user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first #Finds apropriate relation and returns the table row object
    user_stock.destroy
    flash[:notice] = "#{stock.ticker} was successfully removed from your porfolio"
    redirect_to my_portfolio_path
  end
end
