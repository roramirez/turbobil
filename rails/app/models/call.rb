class Call < ActiveRecord::Base
    self.table_name = 'call'


    belongs_to :customer
    belongs_to :provider
    belongs_to :currency
    belongs_to :route
    belongs_to :price_customer
    belongs_to :admin

    def duration_hhmmss
      seconds = 0
      if !duration.nil?
        seconds = duration
      end
      Time.at(seconds).utc.strftime("%H:%M:%S")
    end

end
