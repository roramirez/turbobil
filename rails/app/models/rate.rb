class Rate < ActiveRecord::Base
    self.table_name = 'rate'


    validates :provider, presence: true
    validates :route, presence: true
    validates :priority, presence: true
    validates :price, presence: true

    belongs_to :provider, :class_name => 'Provider', :foreign_key => :provider_id
    belongs_to :route, :class_name => 'Route', :foreign_key => :route_id
end
