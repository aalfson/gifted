class SampleController < ApplicationController
  
  before_filter :check_for_user, :sendSample
  
  #sends sample email
  def sendSample
    
    #figure out how to send flash:success
    
    # current_user.sendSampleEmail
    Recommender.sendSampleEmail.deliver
    redirect_to root_path 
  end
  
  protected
  
  def check_for_user
    if user_signed_in? == false
      redirect_to root_path
    end
  end
  
end
