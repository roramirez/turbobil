class Rate < ActiveRecord::Base
    self.table_name = 'rate'


    validates :provider, presence: true
    validates :route, presence: true
    validates :priority, presence: true
    validates :price, presence: true

    belongs_to :provider
    belongs_to :route
end
