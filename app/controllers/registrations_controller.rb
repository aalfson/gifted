#Registrations controller to handle Svpply authorization redirect after registration

class RegistrationsController < Devise::RegistrationsController
 
  
  protected

  def after_sign_up_path_for(resource)
    #specify Svpply o-auth login url here. 
    '/an/example/path'
  end
end