require 'httparty'
require 'json'
require 'uri'

class User < ActiveRecord::Base
  include HTTParty
  acts_as_birthday :birthday
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :birthday, :recipients
  
  #scopes
  scope :birthday_2_weeks_from_today, find_birthdays_for(Time.now + 2.week, Time.now + 2.week)
  
  
  def sendSampleEmail    
    user = self
    products = getProducts
    recipient = self.email
    Recommender.sendEmail(user, products, recipient).deliver
  end
  
  def sendEmails
    
    user = self
    products = getProducts
    
    
    if user.recipient1 != nil or !user.recipient1.blank?
      Recommender.sendEmail(user, products, user.recipient1).deliver
    end
    if user.recipient2 != nil or !user.recipient2.blank?
      Recommender.sendEmail(user, products, user.recipient2).deliver
    end
    if user.recipient3 != nil or !user.recipient3.blank?
      Recommender.sendEmail(user, products, user.recipient3).deliver
    end
    if user.recipient4 != nil or !user.recipient5.blank?
      Recommender.sendEmail(user, products, user.recipient4).deliver
    end
    if user.recipient5 != nil or !user.recipient5.blank?
      Recommender.sendEmail(user, products, user.recipient5).deliver
    end  
    
  end 
  
  private
  
  def getProducts
    
    zapposSvpplyWants = getZapposSvpplyWants
    
    if zapposSvpplyWants.empty? 
      return nil
    end
    
    zapposProductData = getZapposProductData(zapposSvpplyWants)
    if zapposProductData.empty?
      return nil
    end
    
    zapposProductData
  end
  
  #remove Zappos.com related substrings from title page. These break the search on the Zappos API. 
  def formatSearchTerm(term)
    term.gsub!(" at Zappos.com", "")
    term.gsub!(" - Zappos Couture", "")
    term.gsub!(" - Zappos.com Free Shipping BOTH Ways", "")
    term.gsub!(" at Couture.Zappos.com", "")
    term.gsub!(" - Search Zappos.com", "")
    term
  end
  
  #return an array of hashes populated with price, url, description, and image data for each
  #product in zapposSvpplyWants
  def getZapposProductData(zapposSvpplyWants)

    zapposProductData = Array.new()
    
    key="e2d70f1ead64bafbc86dae4064d789f94644b8ff"
    
    #iterate over each of the zappos products found on Svpply wants list. Collect data for use in emails. 
    zapposSvpplyWants.each do |p|     
      begin
         term = formatSearchTerm(p["page_title"])
         escapedSearchTerm = URI.escape(term)
         
         #this just pulls the first variant from the product - need to work out a better way to select the right variant
         zapposResponse = JSON.parse(HTTParty.get("http://api.zappos.com/Search?term=#{escapedSearchTerm}&key=#{key}").response.body)["results"].first

         productDetails = {
           title: term,
           image: p["image"], 
           buyURL: zapposResponse["productUrl"],
           price: zapposResponse["price"] , 
           }

         zapposProductData.push(productDetails)
      rescue
        # do nothing - will send error email to user. 
      end   
    end
    
    zapposProductData
  end
  
  #Pulls user's wants from Svpply. Returns only those products available for purchase at Zappos
  def getZapposSvpplyWants

    zapposSvpplyWants = Array.new()
    
    begin
      svpplyUserId = self.svpplyUserId
      productsResponse = JSON.parse(HTTParty.get("https://api.svpply.com/v1/users/#{svpplyUserId}/wants/products.json").response.body)["response"]["products"]
    
      #filter out products for sale at Zappos
      productsResponse.each do |p|
        if p["store"].to_s.include?("Zappos")
          zapposSvpplyWants.push(p)
        end
      end
    rescue
      #do nothing - will send error email to user 
    end
    
    zapposSvpplyWants
  end

end

  

