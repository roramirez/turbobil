class TypeCustomer < ActiveRecord::Base
  self.table_name = 'type_customer'

  has_many :customers
end
