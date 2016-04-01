# $1 $2 $3 $4
# endpoints newnode initial-advertise-peer-urls sb-instanceid-etcd

echo "----->join" $2 "into" $1 "with" $3  "use id " $4

export ETCDCTL_ENDPOINT=$1

echo "----->remove $2"
`etcdctl member remove $2 2>&1 |grep  "etcdctl member remove"`

tmpnode=`etcdctl member list |grep $3|awk -F[ '{print $1}' `
etcdctl member remove $tmpnode

echo "----->add $2 $3"
`etcdctl member add $2 $3|grep ETCD_INITIAL_CLUSTER |awk '{print "export " $0}'`
export ETCD_INITIAL_CLUSTER_STATE=existing
export ETCD_NAME=$2

sleep 30

echo "----->start etcd"
etcd -initial-cluster-token $4 -initial-advertise-peer-urls $3 -listen-peer-urls http://0.0.0.0:2380 -listen-client-urls http://0.0.0.0:2379 -advertise-client-urls $1 


