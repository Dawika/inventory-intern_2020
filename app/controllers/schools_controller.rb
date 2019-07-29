class SchoolsController < ApplicationController

    def new
      @school = School.new
      @school.users.build
      @school.school_settings.build
    end
  
    def create
      @school = School.new(school_params)
      # params[:li].each do |l|
      #   @user.li.create(pa)
      # end  
      if @school.save!
        SchoolMailer.school_notification(@school).deliver
        user = @school.users.first
        user.add_role('admin')
        redirect_to change_subdomains_url(subdomain: @school.subdomain_name, id: user)
      else
        redirect_to new_school_path
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
        [{ school_settings_attributes: [:id, :school_year, :semesters] }],
        [{ users_attributes: [:id, :full_name, :email, :password] }]
      )
    end
  end
  