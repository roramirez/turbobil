class RateCustomer < ActiveRecord::Base
    self.table_name = 'rate_customer'


    belongs_to :route, :class_name => 'Route', :foreign_key => :route_id
    belongs_to :price_customer, :class_name => 'PriceCustomer', :foreign_key => :price_customer_id

  def self.get_for_edit(route_id, price_customer_id)
    rate_customer = RateCustomer.find_by route: route_id, price_customer: price_customer_id
    if !rate_customer
      rate_customer = RateCustomer.new

      price_customer = PriceCustomer.find(price_customer_id)
      route = Route.find(route_id)

      rate_customer.route = route
      rate_customer.price_customer = price_customer
      rate_customer.value = price_customer.final_price(route_id, route.price_list)
    end
  rate_customer
  end
end
