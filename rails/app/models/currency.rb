class Currency < ActiveRecord::Base
  self.table_name = 'currency'

  has_many :calls
  has_many :customers
end
