 #!/usr/bin/env python
'Class db for Turbobil'
__author__    = "Rodrigo Ramirez Norambuena"
__version__   = "0.1.0"
__email__     = "rodrigo@blackhole.cl"

import os
import sys
import model
import datetime

from sqlalchemy.orm import sessionmaker
from sqlalchemy.orm.exc import NoResultFound

Session = sessionmaker(bind=model.engine)
session = Session()

class TurboDb:

    def get_customer_by_id(self, id):
        try:
            customer = session.query(model.Customer).\
                        filter(model.Customer.id==id).one()
            return customer
        except NoResultFound, e:
            return None

    def get_customer_by_accountcode(self, accountcode):
        accountcode = self.get_accountcode_by_code(accountcode)
        if accountcode:
            return self.get_customer_by_id(accountcode.customer_id)
        else:
            return None

    def get_accountcode_by_code(self, code):
        try:
            account = session.query(model.Account).\
                      filter(model.Account.code==code).one()
            return account
        except NoResultFound, e:
            return None

    def get_routes_to_customer(self, customer, destination):
        l = len(destination)
        i = 0
        for n in destination:
            prefix = destination[:l-i]
            i += 1
            routes = model.Route.get_by_customer_and_prefix(customer, prefix)
            if routes:
                return routes

    def save_call(self, destination, customer, route, status, price_customer):
        end = datetime.datetime.fromtimestamp(int(status['end'])).strftime('%Y-%m-%d %H:%M:%S')

        cost = 0
        price = 0
        if status['answeredtime'] > 0:
            cost = status['answeredtime'] * route.Rate.price / 60
            price = status['answeredtime'] * price_customer / 60
            self.update_provider_balance(route.Provider, cost)
            self.update_customer_credit(customer, price)

        call = model.Call( destination=destination,
                           admin_id=customer.admin_id,
                           at=end,
                           duration=status['answeredtime'],
                           dialstatus=status['dialstatus'],
                           price_customer_id=customer.price_customer_id,
                           provider_id=route.Provider.id,
                           route_id=route.Route.id,
                           customer_id=customer.id,
                           ip=status['ip'],
                           hangupcause=status['hangupcause'],
                           price_for_customer=price,
                           cost=cost
                         )
        session.add(call)
        session.commit()

    #FIXME: Search other way to do this
    def update_provider_balance(self, Provider, cost):
        s = Session()
        provider = session.query(model.Provider).\
                        filter(model.Provider.id==Provider.id).one()
        provider.balance = provider.balance - cost
        s.commit()

    #FIXME: Search other way to do this
    def update_customer_credit(self, customer, cost):
        s = Session()
        customer = session.query(model.Customer).\
                        filter(model.Customer.id==customer.id).one()
        customer.credit = customer.credit - cost
        s.commit()

    def get_price_customer_route(self, route):
        rate = self.get_price_by_customer_and_route(route.Route.id, route.PriceCustomer.id)
        if rate:
            return rate
        else:
            value = route.Route.price_list
            return value +  (value * route.PriceCustomer.percent_recharge) / 100


    def get_price_by_customer_and_route(self, route, price_customer):
        try:
            price = session.query(model.RateCustomer).\
                      filter(model.RateCustomer.price_customer_id==price_customer,
                             model.RateCustomer.route_id==route).one()
            return price.value
        except NoResultFound, e:
            return None
