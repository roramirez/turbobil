class TypeCustomer < ActiveRecord::Base
    self.table_name = 'type_customer'


    has_many :customers, :class_name => 'Customer'
end
