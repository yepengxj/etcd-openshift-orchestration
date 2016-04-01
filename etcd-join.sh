# $1 $2 $3 
# endpoints newnode initial-advertise-peer-urls 

echo "----->join" $2 "into" $1 "with" $3

export ETCDCTL_ENDPOINT=$1

echo "----->remove $2"
`etcdctl member remove $2 2>&1 |grep  "etcdctl member remove"`
sleep 5
echo "----->add $2 $3"
#`etcdctl member add $2 $3|grep ETCD_INITIAL_CLUSTER |awk '{print "export " $0}'`
export ETCD_INITIAL_CLUSTER="etcd0=http://sb-instanceid-etcd0:2380,etcd2=http://sb-instanceid-etcd2:2380,etcd1=http://sb-instanceid-etcd1:2380,etcd3=http://sb-instanceid-etcd3:2380"
export ETCD_NAME=$2
export ETCD_INITIAL_CLUSTER_STATE=existing

sleep 5
echo "----->start etcd"
etcd -initial-advertise-peer-urls $3 -listen-peer-urls http://0.0.0.0:2380 -listen-client-urls http://0.0.0.0:2379 -advertise-client-urls $1 


