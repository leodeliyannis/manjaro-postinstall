#!/bin/bash
echo "######################################################"
echo "### $0 by constantin.leo@gmail.com ###"
echo "######################################################"

if [ "`id -u`" != "0" ]; then
    echo "Must be run as root"
    exit 1
fi

echo "====================================================================="
echo "======================== fixing XAMPP issues ========================"
echo "====================================================================="
/opt/lampp/lampp stop
chmod 755 /opt/lampp/etc/my.cnf
chmod -R 777 /opt/lampp/var/mysql
chown -hR root:root /opt/lampp
/opt/lampp/lampp start
