class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    include CustomerHelper
    self.table_name = 'customer'

    validates :name, presence: true
    validates :type_pay, presence: true

    validates :password, presence: true, on: :create

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

end
