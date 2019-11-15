class CheckValidatesController < ApplicationController

  def subdomain_uniqueness
    subdomain_not_use = School.where(subdomain_name: params[:subdomain_name]).count.zero?
    render json: { status: subdomain_not_use, message: t('subdomain_uniqueness') }
  end

  def email_uniqueness
    email_not_use = User.where(email: params[:email]).count.zero?
    render json: { status: email_not_use, message: t('email_uniqueness') }
  end

  def user_by_subdomain
    user = User.find_by_email params[:email]
    user_in_school = false

    if user
      if user.super_admin?
        user_in_school = true
      else
        user_in_school = user.school &&
          user.school.subdomain_name.downcase == subdomain.downcase
      end
    end
    render json: { status: user_in_school, message: t('user_not_in_school') }
  end
end
