class PriceCustomer < ActiveRecord::Base
  self.table_name = 'price_customer'

  validates_presence_of :name
  validates_presence_of :percent_recharge
  validates_presence_of :admin_id

  has_many :calls
  has_many :rate_customers

  belongs_to :admin

  def final_price_for_route(route, final_price=nil)
    rate_customer = self.rate_customers.find_by(route: route, price_customer: id)
    if rate_customer
      rate_customer.value
    else
      final_price  + (final_price * percent_recharge) / 100
    end
  end

  def to_s
    name
  end


  def self.get_join_route (id)
   PriceCustomer
    .select("route.*, price_customer.*, route.id as route_id, route.name AS route_name")
    .joins("join route ON route.admin_id = price_customer.admin_id ")
    .where(id: id)
  end

end
