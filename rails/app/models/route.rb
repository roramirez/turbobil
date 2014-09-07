class Route < ActiveRecord::Base
    self.table_name = 'route'


    validates :prefix, presence: true
    validates :price_list, presence: true



    has_many :calls, :class_name => 'Call'
    has_many :rates_customers, :class_name => 'RatesCustomer'
    has_many :rates, :class_name => 'Rate'
    belongs_to :admin, :class_name => 'Admin', :foreign_key => :admin_id

  def to_s
    name
  end

end
