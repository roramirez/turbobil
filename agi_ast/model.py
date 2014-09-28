# this code was initially generate by sqlautocode
# checkout https://code.google.com/p/sqlautocode/

import os
import sys
import ConfigParser

#Import sqlalchemy from lib
dirname, filename = os.path.split(os.path.abspath(__file__))
sys.path.append(os.path.join(dirname,  'lib','sqlalchemy', 'lib'))

from sqlalchemy import *
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relation
from sqlalchemy.orm import sessionmaker
from sqlalchemy.orm.exc import NoResultFound


#Config db
cfg_file = 'config.ini'
cfg = ConfigParser.ConfigParser()
cfg.read(os.path.join(dirname, cfg_file))


#FIXME: Please apply other way to do this, is really ugly
engine = create_engine ('%s://%s:%s@%s:%s/%s'  % (cfg.get('db', 'adapter'),
                                                  cfg.get('db', 'user'),
                                                  cfg.get('db', 'password'),
                                                  cfg.get('db', 'host'),
                                                  cfg.get('db', 'port'),
                                                  cfg.get('db', 'database')
                                                 ), echo=False)

DeclarativeBase = declarative_base()
metadata = DeclarativeBase.metadata
metadata.bind = engine
S = sessionmaker(bind=engine)
s = S()


try:
    from sqlalchemy.dialects.postgresql import *
except ImportError:
    from sqlalchemy.databases.postgres import *


account = Table(u'account', metadata,
    Column('id', INTEGER(), primary_key=True, nullable=False),
    Column('code', TEXT()),
    Column('admin_id', INTEGER(), ForeignKey('admin.id')),
    Column('customer_id', INTEGER(), ForeignKey('customer.id')),
    Column('status', INTEGER()),
    Column('ip_auth', TEXT()),
    Column('password', TEXT()),
)

account_codec = Table(u'account_codec', metadata,
    Column('id', INTEGER(), primary_key=True, nullable=False),
    Column('account_id', INTEGER(), ForeignKey('account.id')),
    Column('codec_id', INTEGER(), ForeignKey('codec.id')),
)

call = Table(u'call', metadata,
    Column('id', INTEGER(), primary_key=True, nullable=False),
    Column('admin_id', INTEGER(), ForeignKey('admin.id')),
    Column('customer_id', INTEGER(), ForeignKey('customer.id')),
    Column('at', TIMESTAMP()),
    Column('duration', INTEGER()),
    Column('provider_id', INTEGER(), ForeignKey('provider.id')),
    Column('route_id', INTEGER(), ForeignKey('route.id')),
    Column('cost', DOUBLE_PRECISION(precision=53)),
    Column('price_for_customer', DOUBLE_PRECISION(precision=53)),
    Column('destination', TEXT()),
    Column('ip', TEXT()),
    Column('hangupcause', TEXT()),
    Column('price_customer_id', INTEGER(), ForeignKey('price_customer.id')),
    Column('currency_id', INTEGER(), ForeignKey('currency.id')),
    Column('dialstatus', TEXT()),
)

customer = Table(u'customer', metadata,
    Column('id', INTEGER(), primary_key=True, nullable=False),
    Column('name', TEXT()),
    Column('email', TEXT()),
    Column('credit', DOUBLE_PRECISION(precision=53)),
    Column('type_pay', INTEGER()),
    Column('customer_id', INTEGER(), ForeignKey('customer.id')),
    Column('type_customer_id', INTEGER(), ForeignKey('type_customer.id')),
    Column('admin_id', INTEGER(), ForeignKey('admin.id')),
    Column('price_customer_id', INTEGER(), ForeignKey('price_customer.id')),
    Column('currency_id', INTEGER(), ForeignKey('currency.id')),
)

provider_codec = Table(u'provider_codec', metadata,
    Column('id', INTEGER(), primary_key=True, nullable=False),
    Column('provider_id', INTEGER(), ForeignKey('provider.id')),
    Column('codec_id', INTEGER(), ForeignKey('codec.id')),
    Column('priority', INTEGER()),
)

rate = Table(u'rate', metadata,
    Column('id', INTEGER(), primary_key=True, nullable=False),
    Column('provider_id', INTEGER(), ForeignKey('provider.id')),
    Column('route_id', INTEGER(), ForeignKey('route.id')),
    Column('priority', INTEGER()),
    Column('price', DOUBLE_PRECISION(precision=53)),
)

rate_customer = Table(u'rate_customer', metadata,
    Column('id', INTEGER(), primary_key=True, nullable=False),
    Column('route_id', INTEGER(), ForeignKey('route.id')),
    Column('value', DOUBLE_PRECISION(precision=53)),
    Column('price_customer_id', INTEGER(), ForeignKey('price_customer.id')),
)

class Account(DeclarativeBase):
    __table__ = account


    #relation definitions


class AccountCodec(DeclarativeBase):
    __table__ = account_codec


    #relation definitions


class Admin(DeclarativeBase):
    __tablename__ = 'admin'

    __table_args__ = {}

    #column definitions
    email = Column('email', TEXT())
    id = Column('id', INTEGER(), primary_key=True, nullable=False)
    name = Column('name', TEXT())

    #relation definitions


class Call(DeclarativeBase):
    __table__ = call


    #relation definitions


class Codec(DeclarativeBase):
    __tablename__ = 'codec'

    __table_args__ = {}

    #column definitions
    code = Column('code', TEXT())
    id = Column('id', INTEGER(), primary_key=True, nullable=False)
    name = Column('name', TEXT())

    #relation definitions


class Currency(DeclarativeBase):
    __tablename__ = 'currency'

    __table_args__ = {}

    #column definitions
    code = Column('code', TEXT())
    id = Column('id', INTEGER(), primary_key=True, nullable=False)
    name = Column('name', TEXT())
    sign = Column('sign', TEXT())
    value_convert = Column('value_convert', DOUBLE_PRECISION(precision=53))

    #relation definitions


class Customer(DeclarativeBase):
    __table__ = customer


    #relation definitions


class PriceCustomer(DeclarativeBase):
    __tablename__ = 'price_customer'

    __table_args__ = {}

    #column definitions
    admin_id = Column('admin_id', INTEGER(), ForeignKey('admin.id'))
    id = Column('id', INTEGER(), primary_key=True, nullable=False)
    name = Column('name', TEXT())
    percent_recharge = Column('percent_recharge', DOUBLE_PRECISION(precision=53))

    #relation definitions


class Protocol(DeclarativeBase):
    __tablename__ = 'protocol'

    __table_args__ = {}

    #column definitions
    id = Column('id', INTEGER(), primary_key=True, nullable=False)
    name = Column('name', TEXT())

    #relation definitions


class Provider(DeclarativeBase):
    __tablename__ = 'provider'

    __table_args__ = {}

    #column definitions
    admin_id = Column('admin_id', INTEGER(), ForeignKey('admin.id'))
    balance = Column('balance', DOUBLE_PRECISION(precision=53))
    email = Column('email', TEXT())
    from_user = Column('from_user', TEXT())
    host = Column('host', TEXT())
    id = Column('id', INTEGER(), primary_key=True, nullable=False)
    name = Column('name', TEXT())
    password = Column('password', TEXT())
    priority = Column('priority', INTEGER())
    protocol_id = Column('protocol_id', INTEGER())
    status = Column('status', INTEGER())
    username = Column('username', TEXT())

    #relation definitions


class ProviderCodec(DeclarativeBase):
    __table__ = provider_codec


    #relation definitions


class Rate(DeclarativeBase):
    __table__ = rate


    #relation definitions

class RateCustomer(DeclarativeBase):
    __table__ = rate_customer


    #relation definitions


class Route(DeclarativeBase):
    __tablename__ = 'route'

    __table_args__ = {}

    #column definitions
    admin_id = Column('admin_id', INTEGER(), ForeignKey('admin.id'))
    id = Column('id', INTEGER(), primary_key=True, nullable=False)
    name = Column('name', TEXT())
    prefix = Column('prefix', TEXT())
    price_list = Column('price_list', DOUBLE_PRECISION(precision=53))

    #relation definitions
    @classmethod
    def get_by_customer_and_prefix(cls, customer, prefix):
        route =  s.query(cls, Provider, Rate, PriceCustomer).\
                   filter(PriceCustomer.admin_id == customer.admin_id, \
                          PriceCustomer.id == customer.price_customer_id,
                          Rate.route_id == Route.id,
                          Provider.id == Rate.provider_id,
                          Provider.admin_id == customer.admin_id,
                          Route.prefix == prefix).\
                    order_by(Rate.priority, Route.prefix).all()

        return route


class TypeCustomer(DeclarativeBase):
    __tablename__ = 'type_customer'

    __table_args__ = {}

    #column definitions
    admin_id = Column('admin_id', INTEGER())
    id = Column('id', INTEGER(), primary_key=True, nullable=False)
    name = Column('name', TEXT())

    #relation definitions


