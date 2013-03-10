require 'httparty'
require 'json'

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
  
  def getSvpplyWants
    
    svpplyUserId = self.svpplyUserId
    productsResponse = JSON.parse(HTTParty.get("https://api.svpply.com/v1/users/#{svpplyUserId}/wants/products.json").response.body)["response"]["products"]
    puts productsResponse
    
  end

end

  

