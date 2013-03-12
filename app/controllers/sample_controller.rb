class SampleController < ApplicationController
  
  before_filter :check_for_user, :sendSample
  
  #sends sample email
  def sendSample
    result = current_user.sendSampleEmail
    
    #respond to ajax call
    respond_to do |format|
      
      #send an error if an error email was sent. 
      if result == nil
        response.status = 500
      end
      format.js
      
    end  
  end
  
  protected
  
  def check_for_user
    if user_signed_in? == false
      redirect_to root_path
    end
  end
  
end
