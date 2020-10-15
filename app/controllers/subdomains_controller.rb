class SubdomainsController < ApplicationController
  def change
    if params[:id].present?
      user = User.find_by(id: params[:id])
      sign_in(:user, user)
      redirect_to after_sign_in_path_for(user)
    end  
  end  

  def change_subdomain_send_mail
    redirect_to edit_user_password_url(@employee, reset_password_token: params[:reset_password_token], subdomain: params[:subdomain_name])
  end

  def send_subdomain_in_mail
    redirect_to path_subdomains_url(subdomain: params[:subdomain_name])
  end

  def path
    redirect_to '/somsri#/inventory'
  end
  
end 
