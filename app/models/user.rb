require 'httparty'

class User < ActiveRecord::Base
  
  include HTTParty
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  serialize :recipients
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :birthday, :recipients
  
  def get_svpply_wants
    
    svpplyCode = self.svpplyCode
    clientSecret = "6ecc07d8fb34184083e036b2e7b180f0"
    clientId = "734b93a296683c18c04dbdfd9c0732f6"
    
    tokenResponse = HTTParty.get("https://svpply.com/oauth/access_token?client_id=#{clientId}&client_secret=#{clientSecret}&code=#{svpplyCode}")
    puts tokenResponse
  
    # response = HTTParty.get("/v1/users/6fbcbef7c618b614ef66ee4a658b0407/wants/products.json")
    
  end

end


