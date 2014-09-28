Database MySQL
--------------

   # Install packages
   sudo aptitude -y install mysql-server mysql-client libmysqlclient-dev python-mysqldb

    # Login MySQL Server
    mysql -u root -p

    # Create user for turbolbil
    # mysql> is part of the prompt
    # Change $password by new secure password
    mysql> CREATE USER 'turbobil'@'localhost' IDENTIFIED BY '$password';

    # Create database 
    mysql> CREATE DATABASE IF NOT EXISTS `turbobil` DEFAULT CHARACTER SET `utf8` COLLATE `utf8_unicode_ci`;


    # Grant the TurboBiluser necessary permissions on the database
    mysql> GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, LOCK TABLES ON `turbobil`.* TO 'turbobil'@'localhost';

    #Exit session on MySQL
    mysql> exit


    # Try connecting to the new database with the new user
    sudo -u turbobil -H mysql -u turbobil -p -D turbobil

    #Type the password setted

    # You should now see a 'mysql>' prompt

    # Exit session on MySQL
      mysql> exit

    # You are done installing the database and can go back to the rest of the installation.
