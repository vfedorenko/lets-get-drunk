class Custom::RegistrationsController < DeviseTokenAuth::RegistrationsController

  def render_create_success
    render json: @resource.json_response
  end

  #Bug in devise_token_auth it calls instead of render_create_error_email_already_exists
  def render_create_error
    render json: {
        status: ErrorCodes::ALREADY_EXISTS
    }, status: 403
  end

  def sign_up_params
    params.permit(devise_parameter_sanitizer.for(:sign_up), :name, :image)
  end

  # def render_create_error_email_already_exists
  #   render json: {
  #       status: '1'
  #   }, status: 403
  # end

  protected
end