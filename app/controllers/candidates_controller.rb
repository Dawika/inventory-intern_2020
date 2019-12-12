class CandidatesController < ApplicationController

  def index
    filter_candidates
    total = @candidates.size
    @candidates = @candidates.offset(params[:offset]).limit(params[:limit])

    render json: {
      rows: @candidates.as_json('data_table'),
      total: total
    }, status: :ok
  end

  def display_file
    data = Candidate.find_by(id: params[:id])
    if data.present?
      data = data.candidate_files.find_by(id:  params[:file_id])
      if data.present?
        url = data.files.expiring_url(10)
        send_file open(url), type: data.files.content_type , disposition: 'inline'
        return
      end
    end
    redirect_to '/404.html'
  end

  def new
    render json: { candidate: Candidate.new.as_json('show_or_edit') }, status: :ok
  end

  def create
    @candidate = Candidate.new(candidate_params)
    @candidate.save
  end

  def edit
    @candidate = Candidate.find(params[:id])
    render json: { candidate: @candidate.as_json('show_or_edit') }, status: :ok
  end

  def show
    render json: { candidate: Candidate.with_deleted.where(id: params[:id]).first.as_json('show_or_edit') }, status: :ok
  end

  def update_candidate
    @candidate = Candidate.find_by(id: params[:id])
    @candidate.update(candidate_params)
  end

  def destroy
    @candidate = Candidate.find_by(id: params[:id])
    @candidate.destroy
    render json: { candidate: @candidate.as_json('show_or_edit') }, status: :ok
  end

  def filter_candidates
    @candidates = if params[:shortlist].present?
                  Candidate.where(shortlist: true).order(created_at: 'desc')
                 else
                  Candidate.where(shortlist: false).order(created_at: 'desc')
                 end
    if params[:search].present?
      search = "%#{params[:search]}%"
      @candidates = @candidates.where('full_name LIKE :search OR
                                  nick_name LIKE :search OR
                                  email LIKE :search OR
                                  candidates.from LIKE :search',
                                  search: search)
    end
    # sort and order
    if params[:sort].present?
      if params[:shortlist] == nil
        params[:shortlist] = false
      end
      case params[:sort]
      when 'link_full_name'
        @candidates = Candidate.where(shortlist: params[:shortlist]).order(full_name: params[:order])
      when 'school_year'
        @candidates = Candidate.where(shortlist: params[:shortlist]).order(school_year: params[:order])
      when 'current_ability'
        @candidates = Candidate.where(shortlist: params[:shortlist]).order(current_ability: params[:order])
      when 'learn_ability'
        @candidates = Candidate.where(shortlist: params[:shortlist]).order(learn_ability: params[:order])
      when 'attention'
        @candidates = Candidate.where(shortlist: params[:shortlist]).order(created_at: params[:order])
      when 'created_at'
        @candidates = Candidate.where(shortlist: params[:shortlist]).order(created_at: params[:order])
      end
    end
  end

  def update_star
    @candidate = Candidate.find_by(id: params[:id])
    @candidate.update(shortlist: params[:shortlist] == "true")
  end

  private

  def candidate_params
    params.require(:candidate).permit(:full_name, :nick_name, :email, :phone, :from, :school_year, :note,
      :current_ability, :learn_ability, :attention, :interest, :image, :shortlist,
      programming_skills_attributes: [:id, :skill_name, :skill_point, :_destroy],
      soft_skills_attributes: [:id, :skill_name, :skill_point, :_destroy],
      design_skills_attributes: [:id, :skill_name, :skill_point, :_destroy],
      candidate_files_attributes: [:id, :files, :_destroy]
    )
  end


end
