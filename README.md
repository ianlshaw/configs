# configs

Master to master sql replication with redundant haproxy load balancing.

Creation of the replication users, and grants are not included in the configs, but are absolutely essential. 

Note when applying the grants that the haproxy_check and haproxy_root users should have grants
to the PRIVATE ip addresses of each load balancer. 

In this setup the floating IP is 10.0.0.25, whereas both load balancers are communicating through
10.0.0.1 and 10.0.0.4. These are the IP's you'll need to assign the grants to.

This can be done with the below:

mysql -u root -p -e "INSERT INTO mysql.user (Host,User) values ('10.0.0.1','haproxy_check'); FLUSH PRIVILEGES;"

mysql -u root -p -e "INSERT INTO mysql.user (Host,User) values ('10.0.0.4','haproxy_check'); FLUSH PRIVILEGES;"

mysql -u root -p -e "GRANT ALL PRIVILEGES ON *.* TO 'haproxy_root'@'10.0.0.4' IDENTIFIED BY 'password' WITH GRANT OPTION; FLUSH PRIVILEGES"

mysql -u root -p -e "GRANT ALL PRIVILEGES ON *.* TO 'haproxy_root'@'10.0.0.4' IDENTIFIED BY 'password' WITH GRANT OPTION; FLUSH PRIVILEGES"
