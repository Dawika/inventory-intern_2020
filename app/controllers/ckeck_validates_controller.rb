class CkeckValidatesController < ApplicationController

  def email_uniqueness
    email_not_use = User.where(email: params[:email]).count == 0
    render json: { status: email_not_use, message: t('email_uniqueness') }
  end

end
