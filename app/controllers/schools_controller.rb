class SchoolsController < ApplicationController
    def new
      @school = School.new
      @school.users.build
      @school.school_settings.build
      @school.build_bil_info
      @plans = Plan.all.order(id: 'asc')
    end

    def create
      ActiveRecord::Base.transaction do
        @school = School.new(school_params)
        @school.auto_subscribe = params[:skip].blank?
        # 4242424242424242 <= credit card number for testing
        token = params[:omise_token]
        if token.present?
          @customer = Omise::Customer.create({
            email: @school.email,
            description: "#{@school.name_eng}",
            card: token
          })
          @school.customer_id = @customer.id
        end
        if @school.save(validate: false)
          @school.create_grades(params[:grades][:name])
          SchoolMailer.school_notification(@school).deliver
          user = @school.users.first
          user.add_role('admin')
          redirect_to change_subdomains_url(subdomain: @school.subdomain_name, id: user)
        else
          redirect_to new_school_path
        end
      end
    end

    def update
      @school = School.find_by(id: params[:id])
      @school.update(params[:logo])
    end

    private

    def school_params
      params.require(:school).permit(
        :name,
        :tax_id,
        :address,
        :zip_code,
        :phone,
        :fax,
        :email,
        :name_eng,
        :note,
        :subdomain_name,
        :branch,
        :logo,
        :plan_id,
        [{ school_settings_attributes: [:id, :school_year, :semesters ] }],
        [{ users_attributes: [:id, :full_name, :email, :password ] }],
        [{ bil_info_attributes: [ :name, :address, :district, :province, :zip_code, :phone, :tax_id, :branch, :company_id ] }]
      )
    end
  end
