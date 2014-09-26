class Call < ActiveRecord::Base
  self.table_name = 'call'
  include Filterable

  belongs_to :customer
  belongs_to :provider
  belongs_to :currency
  belongs_to :route
  belongs_to :price_customer
  belongs_to :admin

  scope :ip, ->(ip) {where(ip: ip)}

  scope :today, -> {where(:at => Date.today...Date.tomorrow)}
  scope :call_end, ->(call_end)  {where("at <= :end_date",  {end_date: call_end})}
  scope :call_start, ->(call_start) {where("at >= :start_date",  {start_date: call_start})}

  def duration_hhmmss
    seconds = 0
    if !duration.nil?
      seconds = duration
    end
    Time.at(seconds).utc.strftime("%H:%M:%S")
  end

end
