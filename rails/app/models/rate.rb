class Rate < ActiveRecord::Base
  self.table_name = 'rate'

  validates_presence_of :provider
  validates_presence_of :route
  validates_presence_of :priority
  validates_presence_of :price

  belongs_to :provider
  belongs_to :route
end
