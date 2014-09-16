class PriceCustomer < ActiveRecord::Base
    self.table_name = 'price_customer'

    validates_presence_of :name
    validates_presence_of :percent_recharge
    validates_presence_of :admin_id

    has_many :calls
    has_many :rates_customers
    belongs_to :admin

  def final_price_for_route(route)
    rate_customer = self.rate_customers.find_by(route: route)
    if rate_customer
      rc.value
    else
      final_price = route.price_list
      final_price  + (final_price * percent_recharge) / 100
    end
  end

  def to_s
    name
  end

end
