class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :rememberable, :trackable, :validatable
  include CustomerHelper
  self.table_name = 'customer'

  validates_presence_of :name
  validates_presence_of :type_pay

  validates :password, presence: true, on: :create
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  has_many :accounts
  has_many :calls

  belongs_to :customer
  belongs_to :currency
  belongs_to :admin
  belongs_to :type_customer
  belongs_to :price_customer

  def type_pay_label
    type_payment type_pay
  end

  def minutes_call_last_days(days=7)
    Call.where(customer: self)
        .where("at >= ?", Time.now - days.days)
        .group('DATE(at)')
        .sum(:duration)
  end

end
