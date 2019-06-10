class SchoolsController < ApplicationController

    def new
      @school = School.new
      @school.users.build
      @school.school_settings.build
    end
  
    def create
      @school = School.new(school_params)
      if @school.save!
        SchoolMailer.school_notification(@school).deliver
        @school.users.first.add_role('admin')
        redirect_to subdomain_url(@school.subdomain_name, new_user_session_path)
      else
        redirect_to new_school_path
      end
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
        [{ school_settings_attributes: [:id, :school_year, :semesters] }],
        [{ users_attributes: [:id, :full_name, :email, :password] }]
      )
    end
  end
  