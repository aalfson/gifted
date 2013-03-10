#Registrations controller to handle Svpply authorization redirect after registration

class RegistrationsController < Devise::RegistrationsController
 
  #before_filter :authenticate_user!
 
  #continues registration after Svpply authorization
  def continue
    current_user.svpplyCode = params[:code]
    current_user.save
  end
  
  #processes registration/continue form and redirects to success page
  def finish
    u = current_user
    u.name = params[:name]
    
    year = params[:birthday]["(1i)"].to_i
    month = params[:birthday]["(2i)"].to_i
    day = params[:birthday]["(3i)"].to_i
    u.birthday = Date.new(year, month, day)
    
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
    
    u.recipients = recipients
    u.save 
  end
  
  protected

  def after_sign_up_path_for(resource)
    #specify Svpply o-auth login url here. 
    '/registration/continue?code=abcdefg'
  end
  
end