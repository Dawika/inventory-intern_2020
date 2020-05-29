class UsersController < ApplicationController
  before_action :authenticate_user!

  def me
    render json: { roles: current_user.roles.pluck(:name) }
  end

  def role_employees
  	id = params[:id]
  	user = User.find(id)
  	render json: { roles: user.roles.pluck(:name) }
  end

  def site_config
    render json: @school_config
  end

  def get_password
    password = current_user.valid_password?(params[:password])
    render json: { password: password }
  end
end
