class Route < ActiveRecord::Base
  self.table_name = 'route'

  validates_presence_of :prefix
  validates_presence_of :price_list

  has_many :calls
  has_many :rates_customers
  has_many :rates

  belongs_to :admin

  def to_s
    name
  end

end
