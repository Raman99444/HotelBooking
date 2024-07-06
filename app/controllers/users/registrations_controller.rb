module Users
  class RegistrationsController < Devise::RegistrationsController
    protected

    # Override the path used after sign up.
    def after_sign_up_path_for(resource)
      authenticated_root_path
    end

    # Override the path used after sign up for inactive accounts.
    def after_inactive_sign_up_path_for(resource)
      authenticated_root_path
    end
  end
end
