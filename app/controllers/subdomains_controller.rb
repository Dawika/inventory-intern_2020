class SubdomainsController < ApplicationController
  def change
    if params[:id].present?
      user = User.find_by(id: params[:id])
      sign_in(:user, user)
      redirect_to after_sign_in_path_for(user)
    end  
  end  
end