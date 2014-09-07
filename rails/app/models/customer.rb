class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    include CustomerHelper
    self.table_name = 'customer'

    validates :name, presence: true
    validates :type_pay, presence: true

    has_many :accounts, :class_name => 'Account'
    has_many :calls, :class_name => 'Call'
    belongs_to :customer, :class_name => 'Customer', :foreign_key => :customer_id
    belongs_to :currency, :class_name => 'Currency', :foreign_key => :currency_id
    belongs_to :admin, :class_name => 'Admin', :foreign_key => :admin_id
    belongs_to :type_customer, :class_name => 'TypeCustomer', :foreign_key => :type_customer_id
    belongs_to :price_customer, :class_name => 'PriceCustomer', :foreign_key => :price_customer_id

    def type_pay_label
      type_payment type_pay
    end

end
