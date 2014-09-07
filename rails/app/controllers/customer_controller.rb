class CustomerController < ApplicationController

  def new
    @customer = Customer.new
  end

  def index
    @customer = Customer.all
  end

  def create
    @customer = Customer.new(params[:customer].permit(:email, :name))
    @customer.save

    redirect_to customer_path
  end
end
