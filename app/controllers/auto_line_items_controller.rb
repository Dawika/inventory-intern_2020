class AutoLineItemsController < ApplicationController
  
  def index
    item = AutoLineItem.where(school_id: current_user.school_id)
    render json: item, status: :ok
  end
end
