#!/usr/bin/env python
'Turbobil agi Asterisk'
__author__    = "Rodrigo Ramirez Norambuena"
__version__   = "0.1.2"
__email__     = "rodrigo@blackhole.cl"

import os
import sys
from turbodb import *
import logging
from agi import *
from dialer import *

#Type pay
PRE_PAY = 1
POST_PAY = 2

# INFO, DEBUG, WARNING, CRITICAL, ERROR
def set_logging(cfg_level=logging.INFO):

    logging.basicConfig(level=cfg_level)

    logFormatter = logging.Formatter("%(asctime)s [%(threadName)s] [%(levelname)s]  %(message)s")
    rootLogger = logging.getLogger()

    consoleHandler = logging.StreamHandler()
    consoleHandler.setFormatter(logFormatter)
    rootLogger.addHandler(consoleHandler)

    logger = logging.getLogger(__name__)

def check_credit(customer):
    """ Check customer credit """
    if customer.type_pay == PRE_PAY:
        if customer.credit <= 0:
            logging.info('customer id %s dont have credit' % customer.id)
            sys.exit()
    elif customer.type_pay == POST_PAY:
        logging.info('customer id %s POST_PAY' % customer.id)
    else:
        logging.error('customer id %s dont have valid method pay' % customer.id)
        sys.exit()

if __name__ == '__main__':
    set_logging()

    accountcode = sys.argv[1].strip()
    destination = sys.argv[2].strip()

    timeout = 45

    database = TurboDb()
    customer = database.get_customer_by_accountcode(accountcode)

    if not customer:
        logging.error('customer not found')
        sys.exit()

    check_credit(customer)

    #TODO
    #Not yet implement
    #if customer.customer_id:
    #check reseller credit
    #    reseller = database.get_customer_by_id(customer.customer_id)
    #    check_credit(reseller)

    #check route
    routes = database.get_routes_to_customer(customer, destination)
    if not routes:
        logging.error('routes not found')
        sys.exit()

    #dialer call
    agi = AGI()
    dialer = dialer(agi)
    for r in routes:
        price = database.get_price_customer_route(r)
        agi.verbose(price)
        if customer.type_pay == PRE_PAY:
            limit = int(customer.credit /(price / 60) * 1000)
        else:
            limit = 10000000

        str_provider = 'SIP/%s@%s_provider,%s' % (destination, r.Provider.id, timeout)
        op_dial =  '|L(%s:0:0),90' % (limit)
        str_dial = str_provider + op_dial
        d_status = dialer.dial(str_dial)

        database.save_call(destination, customer, r, d_status, price)

        if d_status['dialstatus'] in ['NOANSWER', 'CANCEL'] :
            break
        elif d_status['dialstatus'] in ['ANSWER']:
            break
        elif d_status['dialstatus'] in ['CHANUNAVAIL', 'CONGESTION', 'BUSY']:
            continue

    sys.exit()
