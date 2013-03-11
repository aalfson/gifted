require 'httparty'
require 'json'

class User < ActiveRecord::Base
  
  include HTTParty
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :birthday, :recipients
  
  def sendSampleEmail
    
    puts "**** sendSampleEmail called ****"
    
  end
  
  def sendEmails
    
    zapposSvpplyWantsProducts = getZapposSvpplyWants
    
  end 
  
  #Pulls user's wants from Svpply. Returns only those products available for purchase at Zappos
  def getZapposSvpplyWants
    
    svpplyUserId = self.svpplyUserId
    productsResponse = JSON.parse(HTTParty.get("https://api.svpply.com/v1/users/#{svpplyUserId}/wants/products.json").response.body)["response"]["products"]
    
    zapposSvpplyWants = Array.new()
    
    #filter out products for sale at Zappos
    productsResponse.each do |p|
      if p["store"].to_s.include?("Zappos")
        zapposSvpplyWants.push(p)
      end
    end
    
    zapposSvpplyWants
  end

end

  

