class Custom::SessionsController < DeviseTokenAuth::SessionsController
  def render_create_success
      render json: @resource.json_response
  end

  def render_create_error_bad_credentials
    render json: {
        status: '2'
    }, status: 401
  end
end