class Currency < ActiveRecord::Base
    self.table_name = 'currency'


    has_many :calls, :class_name => 'Call'
    has_many :customers, :class_name => 'Customer'
end
