#!/bin/bash
NEWPASS=$(pwgen 15 -c1)
source <(grep -E '^\w+=' var.sh)
#----------------------------------------------------------
#grant permissions with a new random password
#----------------------------------------------------------
#mysql -e "use $DBNAME;"
#mysql -e "GRANT ALL PRIVILEGES ON $DBNAME.* TO '$DBUSERNAME'@'localhost' IDENTIFIED BY '$NEWPASS'; FLUSH PRIVILEGES;"
#mysql -e "FLUSH PRIVILEGES;"
cd $SITEPATH
echo "database name:"$DBNAME > $SITENAME.log
echo "database user:"$DBUSERNAME >> $SITENAME.log
echo "database pass:"$NEWPASS >> $SITENAME.log
#----------------------------------------------------------
#update wp-config.php
#----------------------------------------------------------
sed -i s/database_name_here/$DBNAME/g wp-config.php
sed -i s/username_here/$DBUSERNAME/g wp-config.php
sed -i s/password_here/$NEWPASS/g wp-config.php
sed -i s/localhost/$DBHOST/g wp-config.php
#----------------------------------------------------------
#create mysql database
#----------------------------------------------------------
#mysql -e "create database $DBNAME;"
mysql -u root
use $DBNAME;
GRANT ALL PRIVILEGES ON $DBNAME.* TO '$DBUSERNAME'@'localhost' IDENTIFIED BY '$NEWPASS'; FLUSH PRIVILEGES;
FLUSH PRIVILEGES;
