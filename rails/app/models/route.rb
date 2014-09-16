class Route < ActiveRecord::Base
    self.table_name = 'route'


    validates :prefix, presence: true
    validates :price_list, presence: true



    has_many :calls
    has_many :rates_customers
    has_many :rates
    belongs_to :admin

  def to_s
    name
  end

end
