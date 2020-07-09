class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end
  
  def my_friends
    @friends = current_user.friends
  end
  

  def search
    if params[:friend]
      @friend = params[:friend]
      if @friend
        respond_to do |format|
          format.js { render partial: 'users/friend_result', layout: false }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Couldn't find user"
          format.js { render partial: 'users/friend_result', layout: false }
        end 
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please entersfsfz"
        format.js {render partial: 'users/friend_result', layout: false }
      end
    end
        
    # if params[:friend].present?
    #   @friends = User.search(params[:friend])
    #   if @friends
    #     respond_to do |format|
    #       format.js {render partial: 'users/friend_result' }
    #     end
    #   else
    #     respond_to do |format|
    #       flash.now[:alert] = "Couldn't find user"
    #       format.js { render partial: 'users/friend_result' }
    #     end
    #   end
    # else
    #   respond_to do |format|
    #     flash.now[:alert] = "Please enter a friend name or email to seach"
    #     format.js { render partial: 'users/friend_result' }
    #   end
    # end
  end
end
