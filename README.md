# atomic-fun
I made this repo for me, but if you happen to stumble across it then please enjoy!


### Goals
My hopes and dreams here are:
  - Further my own knowledge
  - Learn more about Docker, flannel, etcd, and Kubernetes
  - Build/test various microservices and immutable infrastructure concepts
  - Configure a resilient three node Vagrant cluster leveraging Project Atomic


### Helpful Commands
Provision:
```sh
vagrant up
vagrant provision
vagrant rsync-auto nucleus
```

Configure:
```sh
cd /vagrant/
ansible-playbook play.yml
```

etcd:
```sh
curl http://127.0.0.1:2379/version | python -m json.tool
curl http://127.0.0.1:2379/v2/stats/self | python -m json.tool
curl http://127.0.0.1:2379/v2/stats/leader | python -m json.tool
curl http://127.0.0.1:2379/v2/stats/store | python -m json.tool
etcdctl cluster-health
etcdctl ls --recursive
etcdctl get /vagrant/network/config
```

flannel:
```sh
docker run -it alpine /bin/sh
ifconfig eth0
ping
```

kubernetes:
```sh
kubectl version
kubectl cluster-info
kubectl get componentstatus
kubectl get nodes
kubectl get namespaces
kubectl get --all-namespaces=true pods -o wide
kubectl get --all-namespaces=true services
kubectl get --all-namespaces=true replicationControllers
kubectl get --all-namespaces=true deployments
```
