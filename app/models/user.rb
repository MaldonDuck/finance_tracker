class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
  
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
  
  def self.search(param)
    param.strip!
    to_send_back = (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
    return nil unless to_send_back
    to_send_back
  end
  
  
  def self.first_name_matches(param)
    matches('first_name', param)
  end
  
  def self.last_name_matches(param)
    matches('last_name', param)
  end
  
  def self.email_matches(param)
    matches('email', param)
  end
  
  def self.matches(field_name, param)
    where("#{field_name} like?", "%#{param}")
  end
end
