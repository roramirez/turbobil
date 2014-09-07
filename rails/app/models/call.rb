class Call < ActiveRecord::Base
    self.table_name = 'call'


    belongs_to :customer, :class_name => 'Customer', :foreign_key => :customer_id
    belongs_to :provider, :class_name => 'Provider', :foreign_key => :provider_id
    belongs_to :currency, :class_name => 'Currency', :foreign_key => :currency_id
    belongs_to :route, :class_name => 'Route', :foreign_key => :route_id
    belongs_to :price_customer, :class_name => 'PriceCustomer', :foreign_key => :price_customer_id
    belongs_to :admin, :class_name => 'Admin', :foreign_key => :admin_id

    def duration_hhmmss
      seconds = 0
      if !duration.nil?
        seconds = duration
      end
      Time.at(seconds).utc.strftime("%H:%M:%S")
    end

end
