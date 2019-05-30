class SubdomainsController < ApplicationController
    # load_and_authorize_resource
    # before_action :authenticate_user!, :selected
    # STATUSES = ['กำลังศึกษา', 'จบการศึกษา', 'ลาออก']
  
    def index
     
    end
  
    def new
      @subdomain = Subdomain.new
     
    end
  
    def create
      @school = School.new(school_params)
      if @school.save!
        sign_in(:user, @school.users.first)
        redirect_to new_subdomain_path
      else
        redirect_to new_school_path
      end
    end
  
    def edit; end
  
    def update
      @update_student = params[:update_student].present?
      @student.update(student_params)
      render 'refresh_table'
    end
  
    def show; end
  
    def destroy
      @student.destroy
      render 'refresh_table'
    end
  
    private
  
    def selected
      @class_levels = ClassLevel.all.order(name: :asc)
      @status = STATUSES
    end
  
    def filter_student
      @students = @students.joins(:class_level)
      # search
      if params[:search].present?
        search = "%#{params[:search]}%"
        @students = @students.where('first_name LIKE :search OR
                                     last_name LIKE :search OR
                                     status LIKE :search OR
                                     class_levels.name LIKE :search',
                                     search: search)
      end
  
      # sort and order
      if params[:sort].present?
        case params[:sort]
        when 'student_code'
          @students = @students.order(id: params[:order])
        when 'full_name'
          @students = @students.order(first_name: params[:order])
        when 'create_at'
          @students = @students.order(created_at: params[:order])
        when 'class_level'
          @students = @students.order("class_levels.name #{params[:order]}")
        when 'status_color'
          @students = @students.order(status: params[:order])
        end
      end
    end
  
    def bootstrap_table_data
      filter_student
  
      total = @students.count
      @students = @students.limit(params[:limit]).offset(params[:offset])
  
      render json: {
        rows: @students.decorate.as_json(decorator_methods:
          [
            :student_code,
            :full_name,
            :create_at,
            :status_color,
            :class_level,
            :action_buttons
          ]),
        total: total
      }
    end
  
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
  