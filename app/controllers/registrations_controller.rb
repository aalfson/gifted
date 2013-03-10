#Registrations controller to handle Svpply authorization redirect after registration

class RegistrationsController < Devise::RegistrationsController

  before_filter :check_for_user, :only => [:continue, :finish]
 
  #continues registration after Svpply authorization
  def continue
      current_user.svpplyCode = params[:code]
      current_user.save
  end
  
  #processes registration/continue form and redirects to success page
  def finish
    
    current_user.name = params[:name]
    
    year = params[:birthday]["(1i)"].to_i
    month = params[:birthday]["(2i)"].to_i
    day = params[:birthday]["(3i)"].to_i
    current_user.birthday = Date.new(year, month, day)
    
    recipients = Array.new()
    
    if (params[:recipient1].to_s.empty? == false)
      recipients = recipients.push(params[:recipient1])
    end
    if (params[:recipient2].to_s.empty? == false)
      recipients = recipients.push(params[:recipient2].to_s)      
    end
    if (params[:recipient3].to_s.empty? == false)
      recipients = recipients.push(params[:recipient3].to_s)      
    end
    if (params[:recipient4].to_s.empty? == false)
      recipients = recipients.push(params[:recipient4].to_s)      
    end
    if (params[:recipient5].to_s.empty? == false)
      recipients = recipients.push(params[:recipient5].to_s)      
    end
    
    current_user.recipients = recipients
    current_user.save 
  end
  
  protected
  
  def check_for_user
    if user_signed_in? == false
      redirect_to root_path
    end
  end

  def after_sign_up_path_for(resource)
    #specify Svpply o-auth login url here. 
    "https://svpply.com/oauth?client_id=734b93a296683c18c04dbdfd9c0732f6&response_type=code&redirect_uri=http://gifted.herokuapp.com/registration/continue&scope=read_basic"
  end
  
end