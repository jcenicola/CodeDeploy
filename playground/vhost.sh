#!/bin/bash
#
#   PARAMETERS
#
# $usr          - User
# $dir          - directory of web files
# $servn        - webserver address without www.
# $cname        - cname of webserver
# EXAMPLE
# Web directory = /var/www/
# ServerName    = domain.com
# cname            = (www or dev).domain.com
#
#
# Check if you execute the script as root user
#
# This will check if directory already exist then create it with path : /directory/you/choose/domain.com
# Set the ownership, permissions and create a test index.php file
# Create a vhost file domain in your /etc/httpd/conf.d/ directory.
# And add the new vhost to the hosts.
#
#
if [ "$(whoami)" != 'root' ]; then
echo "You have to execute this script as root user"
exit 1;
fi
source <(grep -E '^\w+=' var.sh)
mkdir -p $HOSTFOLDER$cnmae.$SITENAME
chown -R $USER:$USER $SITEPATH
chmod -R '755' $SITEPATH
mkdir -p /var/log/httpd/$SITENAME
#
alias=$cname.$SITENAME
#
echo "#### $SITENAME
<VirtualHost $LISTEN:80>
ServerName $SITENAME
ServerAlias $alias
DocumentRoot $SITEPATH
<Directory $SITEPATH>
Options Indexes FollowSymLinks MultiViews
AllowOverride All
Order allow,deny
Allow from all
Require all granted
</Directory>
</VirtualHost>" > /etc/httpd/vhosts/$SITENAME.conf
if ! echo -e /etc/httpd/vhosts/$SITENAME.conf; then
echo "Virtual host wasn't created !"
else
echo "Virtual host created !"
fi
#echo "Would you like me to create ssl virtual host [y/n]? "
#read q
#
#echo "#### $SITENAME
#<VirtualHost $listen:443>
#SSLEngine on
#SSLCertificateFile /etc/httpd/conf.d/$cname_$servn.crt
#SSLCertificateKeyFile /etc/httpd/conf.d/$cname_$servn.key
#ServerName $servn
#ServerAlias $alias
#DocumentRoot $dir$cname_$servn
#<Directory $dir$cname_$servn>
#Options Indexes FollowSymLinks MultiViews
#AllowOverride All
#Order allow,deny
#Allow from all
#Satisfy Any
#</Directory>
#</VirtualHost>" > /etc/httpd/conf.d/ssl.$cname_$servn.conf
#if ! echo -e /etc/httpd/conf.d/ssl.$cname_$servn.conf; then
#echo "SSL Virtual host wasn't created !"
#else
#echo "SSL Virtual host created !"
#fi
#fi
#
echo "127.0.0.1 $SITENAME" >> /etc/hosts
if [ "$alias" != "$SITENAME" ]; then
echo "127.0.0.1 $alias" >> /etc/hosts
fi
#echo "Testing configuration"
#service httpd configtest
#echo "Would you like me to restart the server [y/n]? "
#read q
#if [[ "${q}" == "yes" ]] || [[ "${q}" == "y" ]]; then
service httpd restart
#fi
#echo "======================================"
#echo "All works done! You should be able to see your website at http://$servn"
