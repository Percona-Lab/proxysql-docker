CLUSTER_NAME=${CLUSTER_NAME:-Theistareykjarbunga}
ETCD_HOST=${ETCD_HOST:-10.20.2.4:2379}

for i in $(curl http://$ETCD_HOST/v2/keys/pxc-cluster/$CLUSTER_NAME/ | jq -r '.node.nodes[]?.key' | awk -F'/' '{print $(NF)}')
do
	mysql -h 127.0.0.1 -P6032 -uadmin -padmin -e "INSERT INTO mysql_servers (hostgroup_id, hostname, port, max_replication_lag) VALUES (0, '$i', 3306, 20);"
done

mysql -h 127.0.0.1 -P6032 -uadmin -padmin -e "LOAD MYSQL SERVERS TO RUNTIME; SAVE MYSQL SERVERS TO DISK;"

