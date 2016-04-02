# ETCD在OPENSHIFT上的编排
##对外暴露端口的实现
一个启动pod，三个用于高可用的RC，每个RC负责管理一个POD

	-pod sb-instanceid-etcd0
	-rc sb-instanceid-etcd1
		-pod sb-instanceid-etcd1
	-rc sb-instanceid-etcd2
		-pod sb-instanceid-etcd2
	-rc sb-instanceid-etcd3
		-pod sb-instanceid-etcd3

启动顺序:
1. etcd-outer-boot.yaml生成引导pod
2. 执行init-root-password.sh设置root密码，开启验证，回收guest权限，生成binduser角色
3. etcd-outer-ha.yaml生成高可用的3个rc，他们会根据配置找到etcd并加入。注意编排文件中的root password替换

绑定的时候：执行bind.sh。将用户添加到binduser角色。

