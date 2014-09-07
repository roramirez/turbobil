class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
    self.table_name = 'admin'


    has_many :accounts, :class_name => 'Account'
    has_many :calls, :class_name => 'Call'
    has_many :price_customers, :class_name => 'PriceCustomer'
    has_many :routes, :class_name => 'Route'
    has_many :providers, :class_name => 'Provider'
    has_many :customers, :class_name => 'Customer'
end
