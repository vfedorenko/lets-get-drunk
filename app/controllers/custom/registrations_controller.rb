class Custom::RegistrationsController < DeviseTokenAuth::RegistrationsController

  def render_create_success
    render json: @resource.json_response
  end
  
  #Bug in devise_token_auth it calls instead of render_create_error_email_already_exists
  def render_create_error
    render json: {
        status: '1'
    }, status: 403
  end
  
  # def render_create_error_email_already_exists
  #   render json: {
  #       status: '1'
  #   }, status: 403
  # end
  
  protected
end