#Registrations controller to handle Svpply authorization redirect after registration

class RegistrationsController < Devise::RegistrationsController
 
  def continue
    @code = params[:code]
  end
  
  def finish
    
  end
  
  protected

  def after_sign_up_path_for(resource)
    #specify Svpply o-auth login url here. 
    'registration/continue?code=abcdefg'
  end
  
end