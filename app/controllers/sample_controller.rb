class SampleController < ApplicationController
  
  before_filter :check_for_user, :sendSample
  
  #sends sample email
  def sendSample
    current_user.sendSampleEmail
    
    #respond to ajax call
    respond_to do |format|
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
