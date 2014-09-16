class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
    self.table_name = 'admin'


    has_many :accounts
    has_many :calls
    has_many :price_customers
    has_many :routes
    has_many :providers
    has_many :customers
end
