class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  
 # validates :name, :ticker_symb, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
     
  def stock_tracked?(ticker_symb) #Check if uesr is tracking stock
    stock = Stock.check_db(ticker_symb)
    return false unless stock
    stocks.where(id: stock.id).exists?
  end
  
  def under_stock_limit? #Caps trackable stocks at 10
    stocks.count < 10
  end
         
  def can_track_stock?(ticker_symb)
    under_stock_limit? && !stock_tracked?(ticker_symb)
  end
  
  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end
end
