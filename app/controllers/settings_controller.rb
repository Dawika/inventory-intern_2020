class SettingsController < ApplicationController
  authorize_resource :class => :setting
  skip_before_action :verify_authenticity_token, :only => [:update_current_user, :update_password]

  # GET /settings
  def index
    render json: getSetting(), status: :ok
  end

  def subscription
    current_user.school.auto_subscribe = ActiveRecord::Type::Boolean.new.cast(params[:auto_subscribe])
    current_user.school.save
    render json:  current_user.school.auto_subscribe
  end

  # PATCH /settings
  def update_current_user
    User.transaction do
      update_school_status = true
      if self.can? :update, School
        update_school_status = current_user.school.update(params_school)
        if current_user.school.bil_info.present?
          current_user.school.bil_info.update(params_billing)
        else
          if params[:billing_info] != "null"
            bil = BilInfo.new(params_billing.merge(school_id: current_user.school.id))
            bil.save(validate: false)
          end
        end
      end
        render json: getSetting(), status: :ok  
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

  def change_plan
    current_user.school.plan_id =  params[:plan_id]
    current_user.school.save
  end

  private
    def getSetting
      {
        user: current_user,
        school: current_user.school,
        owner: User.where(school_id: current_user.school.id).with_role(:admin).first,
        school_logo: current_user.school.logo_url,
        licenses: current_user.school.active_license,
        plan: current_user.school.active_license.plan || t('trial'),
        billing_info: current_user.school.bil_info,
        all_plan: Plan.all

      }
    end

    def params_password
      params.require(:user).permit(:password, :password_confirmation, :current_password)
    end

    def params_school
      params.require(:school).permit(:name, :name_eng, :tax_id, :logo, :address, :zip_code, :email, :phone, :fax, :subdomain_name, :branch, :note)
    end

    def params_user
      params.require(:user).permit(:full_name, :email, :password)
    end

    def params_billing
      params.require(:billing_info).permit(:address, :branch, :district, :name, :phone, :province, :tax_id, :zip_code)
    end
end
