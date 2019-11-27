class MoveSiteConfigsToSchoolConfigs < ActiveRecord::Migration[5.0]
  def change
    add_column :school_settings, :enable_rollcall, :bool, default: true
    add_column :school_settings, :default_cash_payment_method, :bool, default: true
    add_column :school_settings, :default_credit_card_payment_method, :bool, default: false
    add_column :school_settings, :default_cheque_payment_method, :bool, default: false
    add_column :school_settings, :default_transfer_payment_method, :bool, default: false
    add_column :school_settings, :display_username_password_on_login, :bool, default: false
    add_column :school_settings, :display_schools_year_with_invoice_id, :bool, default: true
    add_column :school_settings, :web_cms, :bool, default: false
    add_column :school_settings, :tax, :bool, default: true
    add_column :school_settings, :student_number_leading_zero, :integer, default: 0
    add_column :school_settings, :one_slip_per_page, :bool, default: false
    add_column :school_settings, :export_ktb_payroll, :bool, default: false
    add_column :school_settings, :outstanding_notification, :bool, default: false
    add_column :school_settings, :slip_carbon, :bool, default: false
    add_column :school_settings, :default_locale, :string, default: "th"
    add_column :school_settings, :enable_expenses, :bool, default: false
    add_column :school_settings, :expense_tag_tree, :string
    add_column :school_settings, :enable_quotation, :bool, default: false
    add_column :school_settings, :export_kbank_payroll, :bool, default: false
    add_column :school_settings, :bank_account, :string
    add_column :school_settings, :enable_scout, :bool, default: false
    add_column :school_settings, :reserved_subdomains, :string
  end
end
