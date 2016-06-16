#创建root用户密码，并回收guest权限，添加bind用户权限
# $1 rootpassword

# $2 \
# http://sb-ddddddddddd-etcd0:2380 \
# http://sb-ddddddddddd-etcd.app-test.dataos.io:80 \
# $3 \
# sb-ddddddddddd-etcd \
# $4 \
# $5

etcd -name \
 etcd0 \
 -initial-advertise-peer-urls \
 $2 \
 -listen-peer-urls \
 http://0.0.0.0:2380 \
 -listen-client-urls \
 http://0.0.0.0:2379 \
 -advertise-client-urls \
 $3 \
 -initial-cluster-token \
 $4 \
 -initial-cluster \
 etcd0=$2 \
 -initial-cluster-state \
 new

etcdctl user add root << EOF
$1
EOF

etcdctl auth enable

etcdctl -u root:$1 role revoke guest --path '/*' -readwrite

etcdctl -u root:$1 role add binduser

etcdctl -u root:$1 role grant binduser -path '/*' -readwrite

etcdctl -u root:$3 user add $1 << EOF
$5
EOF

etcdctl -u root:$3  user grant $1 -roles binduser

etcdctl -u root:$3 user passwd $1 << EOF
$5
EOF
