class Recommender < ActionMailer::Base
  default from: "giftedDemoApp@gmail.com"

  def sendEmail user, products, recipient
    @greeting = "Hi!"
    @message = "#{user.name}'s birthday is in 2 weeks! Zappos, Svpply, and #{user.name} thought you might like some gift ideas so you can help make #{user.name}'s birthday the best ever."
    @products = products
    
    mail to: "#{recipient}", subject: "#{user.name}'s Birthday Gift Ideas"
  end
  
  def sendErrorEmail user
    @greeting = "Hi #{user.name},"
    @message = "Sorry, we've had some trouble sending out your birthday gift suggestions."
    
    mail to: "#{user.email}", subject: "There was a problem with your birthday gift suggestion email."
  end
  
end
