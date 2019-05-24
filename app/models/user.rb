class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :school
  has_many :invoices, dependent: :destroy
  belongs_to :role
  delegate :can?, :cannot?, :to => :ability

  validates :email, presence: true, allow_blank: false, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, allow_blank: false, confirmation: true

  def ability
    Ability.new(self)
  end

  def admin?
    self.has_role? :admin
  end

  def finance_officer?
    self.has_role? :finance_officer
  end
end
