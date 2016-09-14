# atomic-fun
I made this repo for me, but if you happen to stumble across it then please enjoy!


### Goals
My hopes and dreams here are:
  - Further my own knowledge
  - Learn more about Docker, flannel, etcd, and Kubernetes
  - Build/test various microservices and immutable infrastructure concepts
  - Configure a resilient three node Vagrant cluster leveraging Project Atomic


### Helpful Commands and Tests
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

k8s authentication:
```sh
kubectl config view
curl https://127.0.0.1/version --cacert /etc/kubernetes/certs/ca.pem --user admin:admin
curl https://127.0.0.1/version --cacert /etc/kubernetes/certs/ca.pem -H "Authorization: Bearer MySuperSecureToken"
```

dashboard:
```sh
https://atomic01/ui
kubectl --namespace=kube-system get pods -o wide
kubectl --namespace=kube-system logs 
kubectl --namespace=kube-system get svc kubernetes-dashboard
kubectl --namespace=kube-system get rc kubernetes-dashboard
docker run --net=host --rm -it gcr.io/google_containers/kubernetes-dashboard-amd64:v1.4.0-beta2 --apiserver-host http://localhost:8080
http://atomic01:9090
```

kube-dns / skydns:
```sh
kubectl exec busybox -- nslookup kubernetes
kubectl exec -it busybox /bin/sh
kubectl --namespace=kube-system get pods -o wide
kubectl --namespace=kube-system logs 
docker logs skydns
docker logs kube2sky
docker search gcr.io/google-containers/kube
```

ssl:
```sh
openssl s_client -connect 127.0.0.1:443 2>/dev/null </dev/null | openssl x509 -text | egrep -e CN= -e DNS: -e 'Not (Before|After)'
openssl x509 -in /etc/kubernetes/certs/ca.pem -text -noout | egrep -e CN= -e DNS: -e 'Not (Before|After)'
openssl x509 -in /etc/kubernetes/certs/apiserver.pem -text -noout | egrep -e CN= -e DNS: -e 'Not (Before|After)'
openssl x509 -in /etc/kubernetes/certs/admin.pem -text -noout | egrep -e CN= -e DNS: -e 'Not (Before|After)'
```

cleanup
```sh
kubectl --namespace=kube-system delete svc kubernetes-dashboard
kubectl --namespace=kube-system delete rc kubernetes-dashboard
kubectl --namespace=kube-system delete deployment kubernetes-dashboard
kubectl --namespace=kube-system delete svc kube-dns
kubectl --namespace=kube-system delete rc kube-dns
kubectl --namespace=kube-system delete rc kube-dns-v11
kubectl delete namespace kube-system
```
