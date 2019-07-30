class SchoolsController < ApplicationController

    def new
      @school = School.new
      @school.users.build
      @school.school_settings.build
      @school.build_payment_method_school
    end
  
    def create
      if params[:commit] == "เรื่มต้นใช้งาน"       
        @school = School.new(school_params.merge(plan_id: 2))
        @school.payment_method_school = PaymentMethodSchool.new(payment_method: 'transfer money')
        if @school.save(validate: false)
          SchoolMailer.school_notification(@school).deliver
          user = @school.users.first
          user.add_role('admin')
          redirect_to change_subdomains_url(subdomain: @school.subdomain_name, id: user)
        else
          redirect_to new_school_path
        end
      else      
        @school = School.new(school_params)
        if @school.save!
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
        [{ payment_method_school_attributes: [:payment_method, :cardholder_name, :card_number, :exp_month, :exp_year,
           :cvv, :name, :address, :district, :province, :zip_code, :phone, :tax_id, :branch ] }]
      )
    end
  end
  