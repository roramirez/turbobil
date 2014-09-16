class RateCustomer < ActiveRecord::Base
    self.table_name = 'rate_customer'


    belongs_to :route
    belongs_to :price_customer

    before_create :assign_value

  private
  def assign_value
    return if read_attribute(:value).present?
    value = price_customer.final_price_for_route(route)
    write_attribute(:value, value)
  end
end
