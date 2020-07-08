class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks
  
  validates :name, :ticker, presence: true
  def self.new_lookup(ticker_symb)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
      endpoint: 'https://sandbox.iexapis.com/v1')
    begin
      new(ticker: ticker_symb, name: client.company(ticker_symb).company_name, last_price: client.price(ticker_symb))
    rescue => exception
      return nil
    end
  end
  
  def self.check_db(ticker_symb)
    where(ticker: ticker_symb).first
  end
end
