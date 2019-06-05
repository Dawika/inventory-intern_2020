class SettingsController < ApplicationController
  authorize_resource :class => :setting
  skip_before_action :verify_authenticity_token, :only => [:update_current_user, :update_password]

  # GET /settings
  def index
    render json: getSetting(), status: :ok
  end

  # PATCH /settings
  def update_current_user
    User.transaction do
      update_school_status = true
      if self.can? :update, School
        update_school_status = School.first.update(params_school)
      end
      if current_user.update(params_user) && update_school_status
        render json: getSetting(), status: :ok
      else
        render json: {error: "Cannot update settings."}, status: :bad_request
      end
    end
  end

  # PATCH /settings/update_password
  def update_password
    @user = User.find(current_user.id)
    if @user.update_with_password(params_password)
      bypass_sign_in(@user)
      render json: current_user, status: :ok
    else
      render json: {error: "password invalid."}, status: :bad_request
    end
  end

  private
    def getSetting
      {
        user: current_user,
        school: current_user.school
      }
    end

    def params_password
      params.require(:user).permit(:password, :password_confirmation, :current_password)
    end

    def params_school
      params.require(:school).permit(:name, :name_eng, :tax_id, :address, :zip_code, :phone, :fax, :email)
    end

    def params_user
      params.require(:user).permit(:name, :email)
    end
end
