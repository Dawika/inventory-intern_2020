class CkeckValidatesController < ApplicationController

  def email_uniqueness
    email_not_use = User.where(email: params[:email]).count == 0
    render json: { status: email_not_use, message: email_not_use ? 'อีเมล์นี้สามารถใช้ได้' : 'อีเมล์นี้มีการใช้ไปแล้ว' }
  end

end
