# Turbobil - Billing voip

## Install

This guide is checked on Debian/Ubuntu systems

### Packages
    # Update packages system
    aptitude update
    aptitude upgrade

    # Neccesary packages
    aptitude install sudo git nodejs

    #Add user
    sudo adduser --disabled-login --gecos 'TurboBil' turbobil
    #Add user turbobil to sudoers
    echo "turbobil ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/turbobil



### Database
    # Install PostgreSQL database
    sudo aptitude install -y postgresql postgresql-client libpq-dev

    # Access to PostgreSQL
    sudo -u postgres psql -d template1
    # Create a user
    template1=# CREATE USER turbobil CREATEDB;
    # Create the database
    template1=# CREATE DATABASE turbobil OWNER turbobil;
    # Exit session on database
    template1=# \q

Add this line
    host    turbobil        turbobil        127.0.0.1/32            trust
before
    host    all             all             127.0.0.1/32            md5

on /etc/postgresql/9.3/main/pg_hba.conf

Restart service PostgreSQL
    /etc/init.d/postgresql restart


### Repository and files
    # Go to home user
    cd /home/turbobil
    # Clone repository
    sudo -u turbobil -H git clone https://github.com/roramirez/turbobil.git -b master tbil
    cd tbil
    sudo -u turbobil -H git submodule init
    sudo -u turbobil -H git submodule update


The project is develop in Ruby 2.1.2 and used RVM for install

    su turbobil
    curl -sSL https://get.rvm.io | bash -s --ruby=2.1.2
    source ~/.rvm/scripts/rvm
    rvm --default use 2.1.2
    gem install bundler --no-ri --no-rdoc


#### Config enviroment
    cd tbil/rails/
    bundle install
    cp tbil/rails/config/database.yml.postgresql tbil/rails/config/database.yml
    #initialized db
    rake db:migrate --trace RAILS_ENV=production

    #assets
    rake assets:precompile RAILS_ENV=production

    #set variable env
    export RAILS_ENV=production
    export SECRET_KEY_BASE=$(rake secret)

    #load fixtures
    rake db:fixtures:load

    #run app
    rails s

### Start
and now you have two app
admin http://IP_MACHINE:3000/admins
  - Email: admin@example.com
  - Password: password

For customers http://IP_MACHINE:3000/customers


### Asterisk 

Now Turbobil working with Asterisk

If dont have Asterisk installed check this mini guide 


#### Install dependences

    aptitude install build-essential gcc g++ automake autoconf libtool make \
         libncurses5-dev flex bison patch libtool autoconf \
         linux-headers-$(uname -r) libxml2-dev cmake


#### Compiling and install
Will do this as user root

    cd /usr/src
    wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-1.8.30.0.tar.gz
    tar xvfz asterisk-1.8.30.0.tar.gz
    cd asterisk-1.8.30.0
    ./configure
    make
    make install
    make config
    make samples

#### Configuration
    cp /home/turbobil/tbil/agi_ast/exten_tbill.conf /etc/asterisk
    ln -s /home/turbobil/tbil/agi_ast/ /var/lib/asterisk/agi-bin/tbil
    cp /home/turbobil/tbil/agi_ast/config.ini-dist /home/turbobil/tbil/agi_ast/config.ini

    echo "#include \"/home/turbobil/tbil/rails/config/sips/*.account\"" >> /etc/asterisk/sip.conf
    echo "#include \"/home/turbobil/tbil/rails/config/sips/*.provider\"">> /etc/asterisk/sip.conf
    echo "#include \"exten_tbill.conf\"" >> /etc/asterisk/extensions.conf

    /etc/init.d/asterisk start
