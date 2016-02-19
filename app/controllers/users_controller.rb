class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where.not(id: current_user)
  end

  def add_device_id
    if (current_user.update_attributes(device_id: device_id_params))
      render status: 200
      return
    else
      render status: 400
      return
    end
  end

  private

  def device_id_params
    params.require(:device_id)
  end
end
