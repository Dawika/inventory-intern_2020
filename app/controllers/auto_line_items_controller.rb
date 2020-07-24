class AutoLineItemsController < ApplicationController
  before_action :find_autolineitem, only: [:update, :destroy]

  def index
    item = AutoLineItem.where(school_id: current_user.school_id).order(id: 'desc')
    render json: item, status: :ok
  end

  def create
    AutoLineItem.create(auto_line_item_params)
    index
  end

  def update
    @item.update(auto_line_item_params)
    index
  end

  def destroy
    @item.destroy
    index
  end

  def find_autolineitem
    @item = AutoLineItem.find(params[:id])
  end

  def auto_line_item_params
    params.require(:auto_line_item).permit(:name, :price).merge(school_id: current_user.school_id)
  end
end
