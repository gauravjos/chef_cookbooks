/usr/bin/mysqld --bootstrap --verbose=0
#/usr/sbin/mysqld --bootstrap --verbose=0 $MYSQLD_ARGS
/etc/init.d/mysql start > /dev/null
mysql -u root -p$MYSQL_ROOT_PASSWORD br < br.sql
/etc/init.d/mysql stop > /dev/null
#rm -f $tfile
exec /usr/sbin/mysqld
