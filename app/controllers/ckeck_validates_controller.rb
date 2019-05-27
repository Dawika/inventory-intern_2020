class CkeckValidatesController < ApplicationController

  def subdomain_uniqueness
    subdomain_not_use = School.where(subdomain_name: params[:subdomain_name]).count == 0
    render json: { status: subdomain_not_use, message: t('subdomain_uniqueness') }
  end
  
  def email_uniqueness
    email_not_use = User.where(email: params[:email]).count == 0
    render json: { status: email_not_use, message: t('email_uniqueness') }
  end

end
