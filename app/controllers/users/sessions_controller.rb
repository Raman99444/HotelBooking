class Users::SessionsController < Devise::SessionsController
  respond_to :json, :html

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?

    respond_to do |format|
      format.json do
        render json: {
          status: { code: 200, message: 'Signed in successfully.' },
          data: {
            id: resource.id,
            email: resource.email,
            token: request.env['warden-jwt_auth.token']
          }
        }, status: :ok
      end
      format.html { redirect_to after_sign_in_path_for(resource) }
    end
  end

  def destroy
    super do |resource|
      if request.format.json?
        render json: { status: { code: 200, message: 'Signed out successfully.' } }, status: :ok
        return
      end
    end
  end

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        status: { code: 200, message: 'Signed in successfully.' },
        data: {
          id: resource.id,
          email: resource.email,
          name: resource.name
        }
      }, status: :ok
    else
      render json: {
        status: { message: "User couldn't be signed in successfully. #{resource.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end

  def respond_to_on_destroy
    render json: { message: 'Logged out successfully.' }, status: :ok
  end

  def current_token
    request.env['warden-jwt_auth.token']
  end
end
