#!/bin/bash
#read -p "Enter the server name your want (without www) : " SITENAME
#read -p "Enter a CNAME (e.g. :www or dev for dev.website.com) : " cname
#read -p "Enter the path of directory you wanna use (e.g. : /var/www/, dont forget the /): " HOSTFOLDER
#read -p "Enter the user you wanna use (e.g. : apache) : " USER
#read -p "Enter the listened IP for the server (e.g. : * or specific IP): " LISTEN
#read -p "Enter the database name your want  : " DBNAME
#read -p "Enter the database username : " DBUSERNAME
#read -p "Enter the database host (e.g. localhost or IP of server): " DBHOST

SITENAME='playing.com'
cname='www'
HOSTFOLDER='/var/www/vhosts/'
SITEPATH=$HOSTFOLDER$SITENAME
USER='apache'
LISTEN='*'
DBNAME='wp_test'
DBUSERNAME='wp-admin'
DBHOST='localhost'
