class MenuController < ApplicationController
  authorize_resource :class => false

  def index
  end

  def landing_payroll
    render "menu/angular_view", layout: "application_payroll"
  end

  def landing_invoice
    render "menu/angular_view", layout: "application_invoice"
  end

  def landing_rollcall
    render "menu/angular_view", layout: "application_rollcall"
  end

end
