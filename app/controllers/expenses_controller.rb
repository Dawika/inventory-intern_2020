class ExpensesController < ApplicationController
  load_and_authorize_resource

  # GET /expenses
  def index
    sort = params[:sort]
    order = params[:order]
    search = params[:search_keyword]
    page = params[:page]
    start_date = Time.zone.parse(params[:start_date]).beginning_of_day if isDate(params[:start_date])
    end_date = Time.zone.parse(params[:end_date]).end_of_day if isDate(params[:end_date])

    qry_expenses = Expense.all
    qry_expenses = qry_date_range(qry_expenses, Expense.arel_table[:effective_date], start_date, end_date)
    qry_expenses = qry_expenses.search(search) if search.present?
    qry_expenses = qry_expenses.order("total_cost::FLOAT #{order}") if sort == 'total_cost' && order
    qry_expenses = qry_expenses.order("#{sort} #{order}") if sort != 'total_cost' && order
    qry_expenses = qry_expenses.order("effective_date asc") if !order

    respond_to do |format|
      format.json do
        result = {
          expenses: qry_expenses.paginate(page: page, per_page: 10),
          total_price: qry_expenses.sum(:total_cost)
        }

        if page
          result[:current_page] = result[:expenses].current_page
          result[:total_records] = result[:expenses].total_entries
        end
         render json: result, status: :ok
      end
      @date_time_string = start_end_date_to_string_display(start_date, end_date)
      filename = "#{I18n.t('expense_list')} #{@date_time_string}"
      format.pdf do
        @results = qry_expenses.to_a
        @total_price = @results.inject(0){|sum,e| sum += e.total_cost.to_f }
        render pdf: filename,
                template: "pdf/expense_report.html.erb",
                encoding: "UTF-8",
                layout: 'pdf.html',
                show_as_html: params[:show_as_html].present?
      end
      format.xls do
        results = qry_expenses.to_a
        io_buffer = ExportXls.export_expenses_xls(
          results,
          results.inject(0){|sum,e| sum += e.total_cost.to_f },
          @date_time_string
        )
        send_data(io_buffer.read, filename: "#{filename}.xls")
      end
    end
  end

  def show
    render json: @expense.as_json.merge({
      expense_items: @expense.expense_items,
      img: @expense.img_url.exists? ? @expense.img_url.expiring_url(10) : nil
    })
  end

  # POST /expenses
  def create
    if @expense.save
      render json: @expense, status: :ok
    else
      render json: { message: @expense.errors.full_messages }, status: :bad_request
    end
  end

  # PUT /expenses/:id
  def update
    @expense.expense_items.destroy_all
    if (expense_params[:img_url].class.to_s == "ActionDispatch::Http::UploadedFile")
      if @expense.update(expense_params)
        render json: @expense
      else
        render json: @expense.errors.full_messages, status: :bad_request
      end
    else
      @expense.update(expense_params_no_img)
      render json: @expense
    end
  end

  # DELETE /expense/1
  def destroy
    @expense.destroy
  end

  def upload_photo
     @expense = Expense.where(id: params[:id]).update( upload_photo_params )
     render json: @expense
  end

  def report_by_tag
    @start_date_time = Time.zone.parse(params[:start_date]).beginning_of_day if isDate(params[:start_date])
    @end_date_time = Time.zone.parse(params[:end_date]).end_of_day if isDate(params[:end_date])
    tag_tree = @school_config.expense_tag_tree_hash
    @expense_tags = ExpenseTag.all.to_a

    if tag_tree.present?
      @lv_max = tag_tree[0][:lv]
      qry_expenses = Expense.all
      qry_expenses = qry_date_range(qry_expenses, Expense.arel_table[:effective_date], @start_date_time, @end_date_time)
      qry_expense_items = ExpenseItem.where(expense_id: qry_expenses.pluck(:id))
      qry_expense_items.each do |et|
        parent_ids = et.expense_tag_id.present? ? et.expense_tag.parent : []
        parent_ids.select { |p_id| tag_tree.select { |t| t[:cost] += et.cost * et.amount if t[:id] == p_id } }
      end

      @total_cost = qry_expenses.inject(0){|sum, e| sum += e.total_cost }
      @other_cost = @total_cost - tag_tree.inject(0){|sum, e| e[:lv] == @lv_max ? sum += e[:cost] : sum+=0 }
      @date_time_string = start_end_date_to_string_display(@start_date_time, @end_date_time)
      filename = "#{I18n.t('expenses_classification_report')} #{@date_time_string}"
      @results = tag_tree

      respond_to do |format|
        format.pdf do
          render pdf: filename,
                  template: "pdf/expense_export_report.html.erb",
                  encoding: "UTF-8",
                  layout: 'pdf.html',
                  show_as_html: params[:show_as_html].present?
        end
        format.xls do
          @results = tag_tree
          io_buffer = ExportXls.export_by_tag_xls(
            @results,
            @expense_tags,
            @total_cost,
            @other_cost,
            @lv_max,
            @date_time_string
          )
          send_data(io_buffer.read, filename: "#{filename}.xls")
        end
      end
    end
  end

  def report_by_payment
    @start_date_time = Time.zone.parse(params[:start_date]).beginning_of_day if isDate(params[:start_date])
    @end_date_time = Time.zone.parse(params[:end_date]).end_of_day if isDate(params[:end_date])
    qry_expenses = Expense.all
    qry_expenses = qry_date_range(
                      qry_expenses,
                      Expense.arel_table[:effective_date],
                      @start_date_time,
                      @end_date_time
                    )
    expenses = qry_expenses.select("payment_method, SUM(total_cost) as sum_total_cost")
                            .group("payment_method")
    @results = [
      { payment_method: "เงินสด", total_cost: 0 },
      { payment_method: "บัตรเครดิต", total_cost: 0 },
      { payment_method: "เช็คธนาคาร", total_cost: 0 },
      { payment_method: "เงินโอน", total_cost: 0 },
    ]
    @total_cost = 0
    expenses.each do |e|
      @results.each do |r|
        if e.payment_method == r[:payment_method]
          r[:total_cost] = e.sum_total_cost
          @total_cost += e.sum_total_cost
        end
      end
    end
    @date_time_string = start_end_date_to_string_display(@start_date_time, @end_date_time)
    filename = "#{I18n.t('expenses_payment_report')} #{@date_time_string}"
    respond_to do |format|
      format.pdf do
        render pdf: filename,
                template: "pdf/expense_payment_report.html.erb",
                encoding: "UTF-8",
                layout: 'pdf.html',
                show_as_html: params[:show_as_html].present?
      end
      format.xls do
        results = qry_expenses.to_a
        io_buffer = ExportXls.export_expenses_by_payment_xls(
          @results,
          @total_cost,
          @date_time_string
        )
        send_data(io_buffer.read, filename: "#{filename}.xls")
      end
    end
  end

  def check_setting
    setting = ExpenseTag.all.count
    render json: setting, status: :ok
  end

  private
  def set_cost_to_tag_tree(tag_tree, tag_id, cost)
    tag_tree.each do |th|
      if th[:id] == tag_id
        th[:cost] = (th[:cost] + cost).round(2)
        return cost
      end
    end
  end

  def expense_params
    params.require(:expense).permit(
      :effective_date,
      :expenses_id,
      :detail,
      :total_cost,
      :img_url,
      :payment_method,
      :cheque_bank_name,
      :cheque_number,
      :cheque_date,
      :transfer_bank_name,
      :transfer_date,
      expense_items_attributes: [:detail, :amount, :cost, :expense_tag_id ]
    )
  end

  def expense_params_no_img
    params.require(:expense).permit(
      :effective_date,
      :expenses_id,
      :detail,
      :total_cost,
      :payment_method,
      :cheque_bank_name,
      :cheque_number,
      :cheque_date,
      :transfer_bank_name,
      :transfer_date,
      expense_items_attributes: [:detail, :amount, :cost, :expense_tag_id ]
    )
  end

  def upload_photo_params
    params.require(:expense).permit(:img_url)
  end

end
