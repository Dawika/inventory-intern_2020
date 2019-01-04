class SuppliersController < ApplicationController
	def index

		page = params[:page]

		suppliers = Supplier.all
		suppliers = suppliers.paginate(page: page, per_page: 10)
		result = {}
		if params[:bootstrap_table].to_s == "1" 
			result = suppliers.as_json({ bootstrap_table: true })
		else 
			result = {
				suppliers: suppliers.as_json({ index: true }) #(methods:[:inventories])
			}

			if params[:page]
				result[:current_page] = suppliers.current_page
				result[:total_records] = suppliers.total_entries
			end
		end
		render json: result ,status: :ok
	end

	def show
		suppliers = Supplier.find(params[:id])
		render json: suppliers.as_json(methods:[:inventories]), status: :ok
	end

	def create
		suppliers = Supplier.all
		suppiler = Supplier.new(suppliers_params)
		if suppiler.save
			render json: suppiler, status: :ok
		else
			render json: suppiler.errors.full_messages, status: :ok
		end
	end

	def update
		suppliers = Supplier.find(params[:id])
		suppliers.update(suppliers_params)
		render json: suppliers ,stauts: :ok
	end

	def destroy
		suppliers = Supplier.find(params[:id])
		suppliers.destroy
		render json: { status: :success }
	end

	private
	def suppliers_params
		params.require(:suppiler).permit(:name, :address, :phone_number, :email)
	end
end
